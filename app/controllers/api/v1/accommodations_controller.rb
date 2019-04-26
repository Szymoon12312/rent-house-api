module Api
  module V1
    class AccommodationsController < ApplicationController

      has_scope :available, default: nil, allow_blank: true, only: :index
      has_scope :furnished, type: :boolean
      has_scope :by_price, using: %i[min max], type: :hash
      has_scope :by_city, using: %i[country state city], type: :hash

      def index
        accommodations = apply_scopes(Accommodation).page(params[:page])
        render_success(accommodations, Api::AccommodationSerializer )
      end

      def show
        data = Accommodation.find(params[:id])
        render_success(data, Api::AccommodationSerializer)
      end

      def create
        current_user = User.first
        accommodation = Accommodations::CreateService.call(current_user, accommodation_params)
        render_success(accommodation, Api::AccommodationSerializer)
      end

      private

      def accommodation_params
        params.require(:data).permit!
      end
    end
  end
end
