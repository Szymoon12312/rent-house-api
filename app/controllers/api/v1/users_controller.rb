module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authorize_request, only: :create

      def show
        user = User.find(params[:id])
        render_success(user, Api::UserSerializer)
      end

      def create
        user = User.create!(user_params)
        render_success(user, Api::UserSerializer)
      end

      def destroy
        current_user.destroy!
        render :json, { message: "User Successfuly deleted" }
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :surname, :phone_number)
      end
    end
  end
end
