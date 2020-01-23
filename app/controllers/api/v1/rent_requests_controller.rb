module Api
  module V1
    class RentRequestsController < ApplicationController
      before_action :set_accommodation, only: [:create, :accept_request, :reject_request, :update]
      before_action :set_rent_request,  only: [:reject_request, :accept_request, :cancel_request, :update]

      def index
        request_list = LeasedRequest.for_user(current_user).pending_or_accepted
        render_success(request_list, Api::RentRequestSerializer)
      end

      def create
        renter   = set_renter
        rent_req = Accommodations::AddRentRequestService.call(renter, accommodation)
        render_success(rent_req, Api::RentRequestSerializer)
      end

      def accept_request
        data = Accommodations::AcceptRentRequestService.call(
                  current_user,
                  accommodation,
                  rent_request,
                  rent_request_params
                )
        render_success(data)
      end

      def reject_request
        raise CanCan::AccessDenied unless current_user.has_role?(:owner, accommodation)
        rent_request.update!(status: 'rejected', rejected_at: Time.current)
        head :ok
      end

      def cancel_request
        raise CanCan::AccessDenied unless cancelation_permited?
        rent_request.update!(status: 'canceled', canceled_at: Time.current)
        head :ok
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

      def set_renter
        renter_instance = rent_request_params[:group_id].blank? ? current_user : Group.find(rent_request_params[:group_id])
        raise CanCan::AccessDenied if renter_instance.instance_of?(Group) && !current_user&.has_role?(:admin, renter_instance)
        renter_instance
      end

      def cancelation_permited?
        return true if rent_request.user_id == current_user.id
        group = Group.find(rent_request.group_id)
        return user.has_role?(:admin, group)
      end
    end
  end
end
