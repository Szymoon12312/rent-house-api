module Api
  class AccommodationPropertySerializer < ActiveModel::Serializer
    attributes :kitchen, :bathrooms, :bedrooms, :terrace, :balcony, :furnished
  end
end
