class ApplicationController < ActionController::API
  def render_success(json = {})
    render json: json, status: :ok
  end

  def render_errors(json = {}, status: :unprocessable_entity)
    render json: { errors: json }, status: status
  end
end
