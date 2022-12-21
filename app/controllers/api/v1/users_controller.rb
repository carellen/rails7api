module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!, only: %i[update destroy]
      before_action :set_user, except: %i[index create]

      api :GET, '/users', 'Get users list'
      def index
        render json: UserBlueprint.render(User.all, root: :users), status: :ok
      end

      api :GET, '/users/:id', 'Get user by ID'
      param :id, :number, required: true
      def show
        render json: UserBlueprint.render(@user, root: :user), status: :ok
      end

      api :POST, '/users', 'Create new user'
      param :email, String, required: true
      param :password, String, required: true
      param :password_confirmation, String, required: true
      def create
        @user = User.new(user_params)

        return unprocessable(message: @user.errors.full_messages) unless @user.save

        render json: UserBlueprint.render(@user, root: :user), status: :created
      end

      api :PATCH, '/users/:id', 'Update user'
      param :id, :number, required: true
      param :email, String
      param :password, String
      param :password_confirmation, String
      def update
        return unauthorized if current_user != @user

        return unprocessable(message: @user.errors.full_messages) unless @user.update(user_params)

        render json: UserBlueprint.render(@user, root: :user), status: :ok
      end

      api :DELETE, '/users/:id', 'Delete user by ID'
      param :id, :number, required: true
      def destroy
        return unauthorized if current_user != @user

        @user.destroy
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end

      def set_user
        @user = User.find(params[:id]) # consider using guid instead!
      rescue ActiveRecord::RecordNotFound
        record_not_found
      end
    end
  end
end
