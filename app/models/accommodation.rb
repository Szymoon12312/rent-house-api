class Accommodation < ApplicationRecord
  belongs_to :user

  has_one :price, dependent: :destroy
  has_one :location, dependent: :destroy
  has_one :accommodation_property, dependent: :destroy
  has_one :accommodation_type, dependent: :destroy

  validates_associated  :price, :location, :accommodation_type, :accommodation_property
  validates_presence_of :name, :square_meters, :description

end

