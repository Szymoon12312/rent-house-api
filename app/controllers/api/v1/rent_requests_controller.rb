module Api
  module V1
    class RentRequestsController < ApplicationController
      before_action :set_accommodation, only: [:create, :update]
      before_action :set_rent_request,  only: [:reject_request, :cancel_request, :update]

      def index
        request_list = LeasedRequest.for_user(current_user).pending
        render_success(request_list, Api::RentRequestSerializer)
      end

      def create
        renter   = rent_request_params[:group_id].blank? ? current_user : Group.find(rent_request_params[:group_id])
        rent_req = Accommodations::AddRentRequestService.call(renter, accommodation)
        render_success(rent_req, Api::RentRequestSerializer)
      end

      def accept_request
        binding.pry
        Accommodations::AceptRentRequestService.call(
          current_user,
          accommodation,
          rent_request,
          rent_request_params
        )
      end

      def reject_request
        raise CanCan::AccessDenied unless current_user.has_role?(:owner, accommodation)
        rent_request.update!(status: 'rejected', rejected_at: Time.current)
        render_success(rent_request, Api::RentRequestSerializer)
      end

      def cancel_request
        raise CanCan::AccessDenied unless cancelation_permited?
        rent_request.update!(status: 'canceled', canceled_at: Time.current)
      end

      private

      attr_accessor :accommodation, :rent_request

      def rent_request_params
        params.require(:rent).permit(:group_id, :discount, :fee, :leased_from, :leased_to)
      end

      def set_accommodation
        @accommodation = Accommodation.find(params[:id])
      end

      def set_rent_request
        @rent_request = LeasedRequest.find(params[:request_id])
      end

      def cancelation_permited?
        return true if rent_request.user_id == current_user.id
        group = Group.find(rent_request.group_id)
        return user.has_role?(:admin, group)
      end
    end
  end
end
