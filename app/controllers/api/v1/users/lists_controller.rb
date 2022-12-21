module Api
  module V1
    module Users
      class ListsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_list, only: %i[show update destroy]

        api :GET, '/users/lists', 'Get ALL user`s ToDo lists'
        def index
          render json: ListBlueprint.render(current_user.lists.includes(:list_items), root: :user_lists), status: :ok
        end

        api :GET, '/users/lists/:id', 'Get user`s ToDo list by ID'
        param :id, :number, required: true
        def show
          render json: ListBlueprint.render(@list, root: :user_list), status: :ok
        end

        api :POST, '/users/lists', 'Create new user`s ToDo list'
        param :name, String, required: true
        param :shared, [true, false]
        def create
          @list = current_user.lists.build(list_params)

          return unprocessable(message: @list.errors.full_messages) unless @list.save

          render json: ListBlueprint.render(@list, root: :user_list), status: :created
        end

        api :PATCH, '/users/lists/:id', 'Update user`s ToDo list'
        param :id, :number, required: true
        param :name, String
        param :shared, [true, false]
        def update
          return unprocessable(message: @user.errors.full_messages) unless @list.update(list_params)

          render json: ListBlueprint.render(@list, root: :user_list), status: :ok
        end

        api :DELETE, '/users/lists/:id', 'Delete user`s ToDo list by ID'
        param :id, :number, required: true
        def destroy
          @list.destroy
        end

        private

        def list_params
          params.permit(:name, :shared)
        end

        def set_list
          @list = current_user.lists.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          record_not_found
        end
      end
    end
  end
end
