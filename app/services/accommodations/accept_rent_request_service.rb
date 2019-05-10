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
                            rent_request.blak? or
                            params.blank?
                          )
      new(user, accommodation, rent_request, params).call
    end

    def call
      add_rent_request
    end

    private

    attr_accessor :user, :accommodation, :rent_request, :params

    def check_permision?
      user.has_role(:owner, accommodation)
    end

    def get_accommodation_leased_params
      params&.slice(*AccommodationLeased.attribute_names)
    end

    def update_rent_request
      #TODO PDF GENERATOR
      raise CanCan::AccessDenied unless check_permision?
      ActiveRecord::Base.transaction do
        rent_request.update!(status: 'accepted', accepted_at: Time.current)
        AccommodationLeased.create!(get_accommodation_leased_params)
      end
    end
  end
end
