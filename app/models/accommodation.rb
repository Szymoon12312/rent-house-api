class Accommodation < ApplicationRecord
  resourcify

  after_create :assigne_owner

  belongs_to :user

  has_one :price, dependent: :destroy
  has_one :location, dependent: :destroy
  has_one :accommodation_property, dependent: :destroy
  has_one :accommodation_type, dependent: :destroy
  has_many :accommodation_leaseds, dependent: :destroy
  has_many :leased_requests, dependent: :destroy
  has_many_attached :images

  validates_associated  :price, :location, :accommodation_type, :accommodation_property
  validates_presence_of :name, :square_meters, :description, :user

  scope :furnished, ->{ joins(:accommodation_property).where(accommodation_properties: { furnished: true }) }
  scope :available, ->(*) { where(available: true) }
  scope :by_price,  ->(min, max) { joins(:price).where('prices.value >= ? AND prices.value <= ?', min, max)}
  scope :by_city,   -> city { joins(:location).where('locations.city = ?', city.capitalize )}
  scope :by_user,   -> user_id { where('user_id = ?', user_id )}

  private

  def assigne_owner
    self.user.add_role(:owner, self)
  end

  def leased_agreement_data(agreement_data)
    {
      flor: params
    }.merge!(agreement_data)
  end

end

