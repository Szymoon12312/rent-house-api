class Location < ApplicationRecord
  belongs_to :accommodation

  geocoded_by :address
  after_validation :geocode

  private

  def address
    [street, city, state, country].compact.join(', ')
  end
end
