class Accommodation < ApplicationRecord
  resourcify

  belongs_to :user

  has_one :price, dependent: :destroy
  has_one :location, dependent: :destroy
  has_one :accommodation_property, dependent: :destroy
  has_one :accommodation_type, dependent: :destroy

  validates_associated  :price, :location, :accommodation_type, :accommodation_property
  validates_presence_of :name, :square_meters, :description

  scope :furnished, -> { joins(:accommodation_property).where(accommodation_properties: { furnished: true }) }
  scope :available, ->(*) { where(available: true) }
  scope :by_price, -> min, max { joins(:price).where('prices.value >= ? AND prices.value <= ?', min, max)}
  scope :by_city, -> country, state, city { joins(:location).where('locations.country = ? AND locations.state = ? AND locations.city = ?', country, state, city)}
end

