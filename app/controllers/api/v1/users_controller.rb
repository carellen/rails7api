module Api
  module V1
    class UsersController < ApplicationController
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
        if @user.save
          render json: UserBlueprint.render(@user, root: :user), status: :created
        else
          render json: {
            error: {
              type: 'invalid_params_error',
              message: @user.errors.full_messages
            }
          }, status: :unprocessable_entity
        end
      end

      api :PATCH, '/users/:id', 'Update user'
      param :id, :number, required: true
      param :email, String
      param :password, String
      param :password_confirmation, String
      def update
        if @user.update(user_params)
          render json: UserBlueprint.render(@user, root: :user), status: :ok
        else
          render json: {
            error: {
              type: 'invalid_params_error',
              message: @user.errors.full_messages
            }
          }, status: :unprocessable_entity
        end
      end

      api :DELETE, '/users/:id', 'Delete user by ID'
      param :id, :number, required: true
      def destroy
        @user.destroy
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end

      def set_user
        @user = User.find(params[:id]) # consider using guid instead!
      rescue ActiveRecord::RecordNotFound
        render json: {
          error: {
            type: 'invalid_params_error',
            message: 'User not found'
          }
        }, status: :not_found
      end
    end
  end
end
