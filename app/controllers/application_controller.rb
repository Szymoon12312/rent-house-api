class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordInvalid do |exeption|
    render_errors exeption.message
  end

  def render_success(data, serializer, options = {})
    options.camelize_keys!
    key = data.respond_to?(:read_attribute_for_serialization) ? 'serializer' : 'each_serializer'
    render json: data, "#{key}": serializer, meta: options['meta'], root: :data, status: :ok
  end

  def render_errors(json = {}, status: :unprocessable_entity)
    render json: { errors: json }, status: status
  end
end
