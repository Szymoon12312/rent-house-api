class Accommodation < ApplicationRecord
  belongs_to :user

  has_one :price
  has_one :location
  has_one :accommodation_property
  has_one :accommodation_type

end
