module Api
  class AccommodationSerializer < ActiveModel::Serializer
    attributes :name, :description, :square_meters, :id, :images

    belongs_to :user

    has_one :accommodation_type
    has_one :accommodation_property, serializer: AccommodationPropertySerializer
    has_one :location, serializer: LocationSerializer
    has_one :price

    def images
      urls = []
      object.images.each do |image|
        urls << "http://localhost:3001" + Rails.application.routes.url_helpers.rails_blob_url(image,disposition: "attachment", only_path: true)
      end
      urls
    end
  end
end
