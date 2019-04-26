module Api
  class AccommodationSerializer < ActiveModel::Serializer

    # self.config.adapter = :json
    # self.config.root = true

    attributes :name, :description, :square_metes

    # belongs_to :user

    has_one :location, serializer: LocationSerializer
    # has_one :price
  end
end
