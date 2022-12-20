module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, except: %i[index create]

      def index
        render json: { users: User.all }, status: :ok
      end

      def show
        render json: { user: @user }, status: :ok
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: { user: @user }, status: :created
        else
          render json: {
            error: {
              type: 'invalid_params_error',
              message: @user.errors.full_messages
            }
          }, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: { user: @user }, status: :ok
        else
          render json: {
            error: {
              type: 'invalid_params_error',
              message: @user.errors.full_messages
            }
          }, status: :unprocessable_entity
        end
      end

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
