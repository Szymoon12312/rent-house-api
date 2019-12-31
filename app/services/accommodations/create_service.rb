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

    def dig_with_parse
      JSON.parse(params.dig(:accommodation))
    end

    def accommodation_params
      dig_with_parse&.slice(*Accommodation.attribute_names)
    end

    def accommodation_type_params
      dig_with_parse.dig("type")&.slice(*AccommodationType.attribute_names) #TODO remove slice
    end

    def accommodation_property_params
      dig_with_parse.dig("property")&.slice(*AccommodationProperty.attribute_names)
    end

    def create_accommdation!
      acc                         = Accommodation.new(accommodation_params)
      acc.user                    = user
      acc.location                = Location.new(JSON.parse(params[:location]))
      acc.price                   = Price.new(JSON.parse(params[:price]))
      acc.accommodation_type      = AccommodationType.new(accommodation_type_params)
      acc.accommodation_property  = AccommodationProperty.new(accommodation_property_params)
      acc.images.attach(params[:images])
      acc.save!
      acc
    end
  end
end
