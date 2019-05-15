module Accommodations
  class AddRentRequestService
    def initialize(renter, accommodation)
      @renter        = renter
      @accommodation = accommodation
    end

    def self.call(renter, accommodation)
      raise ArgumentError if renter.blank? or accommodation.blank?
      new(renter, accommodation).call
    end

    def call
      add_rent_request
    end

    private

    attr_accessor :renter, :accommodation

    def add_rent_request
      rent_request               = LeasedRequest.new()
      rent_request.user          = renter if renter.instance_of?(User)
      rent_request.group         = renter if renter.instance_of?(Group)
      rent_request.accommodation = accommodation
      rent_request.save! ? rent_request : nil
    end
  end
end
