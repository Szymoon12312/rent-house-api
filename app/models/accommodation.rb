class Accommodation < ApplicationRecord
  resourcify

  after_create :assigne_owner

  belongs_to :user

  has_one :price, dependent: :destroy
  has_one :location, dependent: :destroy
  has_one :accommodation_property, dependent: :destroy
  has_one :accommodation_type, dependent: :destroy
  has_many :accommodation_leaseds, dependent: :destroy

  validates_associated  :price, :location, :accommodation_type, :accommodation_property
  validates_presence_of :name, :square_meters, :description, :user

  scope :furnished, -> { joins(:accommodation_property).where(accommodation_properties: { furnished: true }) }
  scope :available, ->(*) { where(available: true) }
  scope :by_price,  ->(min, max) { joins(:price).where('prices.value >= ? AND prices.value <= ?', min, max)}
  scope :by_city,   ->(country, state, city) { joins(:location).where('locations.country = ? AND locations.state = ? AND locations.city = ?', country, state, city)}

  private

  def assigne_owner
    self.user.add_role(:owner, self)
  end


end

