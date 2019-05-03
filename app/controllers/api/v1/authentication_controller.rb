module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authorize_request

      def authenticate
        @user = User.find_by_email(params[:email])
        if @user&.valid_password?(params[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.now + 24.hours.to_i
          render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                         user_id: @user.id }, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end
    end
  end
end
