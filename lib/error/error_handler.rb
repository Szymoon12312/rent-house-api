module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from ActiveRecord::RecordNotFound do |e|
          respond(:record_not_found, 404, e.to_s)
        end
        rescue_from CustomError do |e|
          respond(e.status, e.error, e.message)
        end
        rescue_from CanCan::AccessDenied do |e|
          respond(:unauthorized, 422, e.to_s)
        end
        rescue_from ActiveRecord::RecordInvalid do |e|
          respond(:unprocessable_entity, 422, e.to_s)
        end
      end
    end

    private

    def respond(_error, _status, _message)
      json = Helpers::Render.json(_error, _status, _message)
      render json: json, status: _status
    end
  end
end
