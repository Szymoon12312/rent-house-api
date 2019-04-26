module Accommodations
  class CreateService

    def initialize(user, params)
      @params = params
      @user   = user
    end

    def self.call(user, params)
      raise ArgumentError if params.blank? || user.blank?
      new(user, params).call
    end

    def call
      create_accommdation!
    end

    private

    attr_reader :params, :user

    def accommodation_params
      params.dig(:accommodation)&.slice(*Accommodation.attribute_names)
    end

    def accommodation_type_params
      params.dig(:accommodation).dig(:type)&.slice(*AccommodationType.attribute_names)
    end

    def accommodation_property_params
      params.dig(:accommodation).dig(:property)&.slice(*AccommodationProperty.attribute_names)
    end

    def create_accommdation!
      acc                         = Accommodation.new(accommodation_params)
      acc.user                    = user #Gona set user from session
      acc.location                = Location.new(params[:location])
      acc.price                   = Price.new(params[:price])
      acc.accommodation_type                    = AccommodationType.new(accommodation_type_params)
      acc.accommodation_property  = AccommodationProperty.new(accommodation_property_params)

      acc.save! ? acc : nil
    end
  end
end

# {
#   "accommodation": {
#   "name": "Test2",
#   "square_meters": 12,
#   "description": "test desc",
#   "type": {"name": "test"},
#   "property": {
#     "kitchen": 2,
#     "furnished": true
#   }
#   },
#   "location": {
#     "country": "Poland",
#     "city": "Rzeszow",
#     "state": "Podkarpacie",
#     "street": "3 maja"
#   },
#   "price": {
#     "name": "monthly",
#     "value": 200
#   }
#}
