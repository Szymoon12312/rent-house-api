class AccommodationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name,:description,:square_metes

  belongs_to :user

  has_one :location
  has_one :price
end
