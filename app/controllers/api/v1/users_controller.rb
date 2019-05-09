module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authorize_request, only: :create

      def create
        user = User.create!(user_params)
        render_success(user, Api::UserSerializer)
      end

      def destroy
        user = User.find(params[:id])
        if user == current_user
          user.destroy!
          render :json, { message: "User Successfuly deleted" }
        else
          render_error "Smth went wrong"
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :phone_number)
      end
    end
  end
end
