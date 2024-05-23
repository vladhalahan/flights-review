# frozen_string_literal: true

module Api
  module V1
    class AuthController < ApiController
      before_action :authenticate, only: %i[logout]

      def create
        user = User.find_by(email: params[:user][:email])

        if user&.authenticate(params[:user][:password])
          session[:user_id] = user.id
          render json: { status: :success, logged_in: true }, status: :no_content
        else
          render json: { status: :error, logged_in: false }, status: :bad_request
        end
      end

      def logout
        reset_session

        render json: { logged_in: false }, status: :ok
      end

      def logged_in
        if current_user
          render json: { email: current_user&.email, logged_in: true }, status: :ok
        else
          render json: { logged_in: false }, status: :ok
        end
      end
    end
  end
end
