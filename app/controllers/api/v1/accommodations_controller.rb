module Api
  module V1
    class AccommodationsController < ApplicationController
      skip_before_action :authorize_request, only: [:index, :show, :show_pdf]

      has_scope :available, default: nil, allow_blank: true, only: :index
      has_scope :furnished, type: :boolean
      has_scope :by_price, using: %i[min max], type: :hash
      has_scope :by_city
      has_scope :by_user

      load_and_authorize_resource :only => [:destroy, :update]

      def index
        accommodations = apply_scopes(Accommodation).page(params[:page])
        render_success(accommodations, Api::AccommodationSerializer )
      end

      def show
        data = Accommodation.find(params[:id])
        render_success(data, Api::AccommodationSerializer)
      end

      def update; end

      def create
        accommodation = Accommodations::CreateService.call(current_user, accommodation_params)
        render_success(accommodation, Api::AccommodationSerializer)
      end

      def destroy; end

      def show_pdf
        binding.pry
        pdf = Gpdfs::Generators::LeaseAgreement.call
        binding.pry
        send_data pdf
      end

      private

      def accommodation_params
        params.permit(:accommodation,:location,:price,images: [])
      end
    end
  end
end
