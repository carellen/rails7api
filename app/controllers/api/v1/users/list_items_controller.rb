module Api
  module V1
    module Users
      class ListItemsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_list
        before_action :set_list_item, only: %i[update destroy]

        api :POST, '/users/lists/:list_id/list_items', 'Create new user`s ToDo list item'
        param :short_name, String, required: true
        param :status, ListItem.statuses.keys
        param :description, String
        def create
          @list_item = @list.list_items.build(list_item_params)

          return unprocessable(message: @list.errors.full_messages) unless @list_item.save

          render json: ListBlueprint.render(@list, root: :user_list), status: :created
        end

        api :PATCH, '/users/lists/:list_id/list_items/:id', 'Update user`s ToDo list item'
        param :id, :number, required: true
        param :short_name, String
        param :status, ListItem.statuses.keys
        param :description, String
        def update
          return unprocessable(message: @list_item.errors.full_messages) unless @list_item.update(list_item_params)

          render json: ListBlueprint.render(@list, root: :user_list), status: :ok
        end

        api :DELETE, '/users/lists/:list_id/list_items/:id', 'Delete user`s ToDo list item by ID'
        param :id, :number, required: true
        def destroy
          @list_item.destroy
        end

        private

        def list_item_params
          params.permit(:short_name, :status, :description)
        end

        def set_list
          @list = current_user.lists.find(params[:list_id])
        rescue ActiveRecord::RecordNotFound
          record_not_found
        end

        def set_list_item
          @list_item = @list.list_items.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          record_not_found
        end
      end
    end
  end
end
