module Accommodations
  class AcceptRentRequestService
    def initialize(user, accommodation, rent_request, params)
      @user          = user
      @accommodation = accommodation
      @rent_request  = rent_request
      @params        = params
    end

    def self.call(user, accommodation, rent_request, params)
      raise ArgumentError if (
                            user.blank? or
                            accommodation.blank? or
                            rent_request.blank? or
                            params.blank?
                          )
      new(user, accommodation, rent_request, params).call
    end

    def call
      accept_rent_request!
    end

    private

    attr_accessor :user, :accommodation, :rent_request, :params, :acc_leased

    def check_permision?
      user.has_role?(:owner, accommodation)
    end

    def get_accommodation_leased_params
      params&.slice(*AccommodationLeased.attribute_names)
    end

    def set_renter!
      rent_request.user ? acc_leased.user = rent_request.user : acc_leased.group = rent_request.group
    end

    def set_final_price!
      #Need to check if discount > price/ Think of discount type % or Amount
      acc_leased.leased_price = acc_leased.price.value - params[:discount]
    end

    def accept_rent_request!
      #TODO PDF GENERATOR -> Here or create another endpoint for accepted request
      #Notify on email
      raise CanCan::AccessDenied unless check_permision?
      ActiveRecord::Base.transaction do
        rent_request.update!(status: 'accepted', accepted_at: Time.current)
        @acc_leased = AccommodationLeased.new(get_accommodation_leased_params)
        @acc_leased.accommodation = accommodation
        @acc_leased.price = accommodation.price
        set_renter!
        set_final_price!
        @acc_leased.save! ? acc_leased : nil
      end
    end
  end
end
