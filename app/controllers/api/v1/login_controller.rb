module Api
  module V1
    class LoginController < ApplicationController

      api :POST, '/login', 'Login user'
      param :email, String, required: true
      param :password, String, required: true
      def create
        user = User.find_by(email: login_params[:email])
        auth = user&.authenticate(login_params[:password]) && auth_provider.login(user: user)

        return unprocessable(message: 'Email or password is incorrect') unless auth

        render json: { token: auth[:result] }, status: :ok
      end

      api :DELETE, '/login', 'Logout user'
      def destroy
        auth_provider.logout(token: auth_token)
      end

      private

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end
