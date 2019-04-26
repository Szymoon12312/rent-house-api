module Api
  class LocationSerializer < ActiveModel::Serializer
    attributes :country, :state, :city, :street, :longitude, :latitude
  end
end
