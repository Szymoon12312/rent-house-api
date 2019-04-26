module Api
  class LocationSerializer < ActiveModel::Serializer
    attributes :country, :city
  end
end
