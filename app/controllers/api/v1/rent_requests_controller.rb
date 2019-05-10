module Api
  module V1
    class RentRequestsController < ApplicationController
      before_action :set_accommodation

      def create
        renter   = rent_request_params[:group_id].blank? ? current_user : Group.find(rent_request_params[:group_id])
        rent_req = Accommodations::AddRentRequestService.call(renter,accommodation)
        render_success(rent_req, Api::RentRequestSerializer)
      end

      private

      attr_accessor :accommodation

      def set_accommodation
        @accommodation = Accommodation.find(params[:id])
      end

      def rent_request_params
        params.require(:rent).permit!
      end
    end
  end
end
