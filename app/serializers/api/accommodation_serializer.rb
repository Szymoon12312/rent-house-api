module Api
  class AccommodationSerializer < ActiveModel::Serializer
    attributes :name, :description, :square_meters

    belongs_to :user

    has_one :location, serializer: LocationSerializer
    has_one :price
  end
end
