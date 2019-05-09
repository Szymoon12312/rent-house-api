class ApplicationController < ActionController::API
  before_action :authorize_request

  include Error::ErrorHandler

  attr_reader :current_user

  def render_success(data, serializer, options = {})
    options.camelize_keys!
    key = data.respond_to?(:read_attribute_for_serialization) ? 'serializer' : 'each_serializer'
    render json: data, "#{key}": serializer, meta: options['meta'], root: :data, status: :ok
  end

  def render_errors(json = {}, status: :unprocessable_entity)
    render json: { errors: json }, status: status
  end

  private

  def authorize_request
    header = request.headers['Authorization']&.split(' ')&.last
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
