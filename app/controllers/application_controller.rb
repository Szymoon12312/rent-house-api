class ApplicationController < ActionController::API
  include Error::ErrorHandler

  before_action :authorize_request

  attr_reader :current_user

  def render_success(data, serializer = {}, options = {})
    options.camelize_keys!
    return render json: data, meta: options['meta'],  status: :ok if serializer.blank?
    key = data.respond_to?(:read_attribute_for_serialization) ? 'serializer' : 'each_serializer'
    render json: data, "#{key}": serializer,root: :data, meta: options['meta'], status: :ok
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
