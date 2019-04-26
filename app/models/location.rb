class Location < ApplicationRecord
  belongs_to :accommodation

  geocoded_by :address

  after_validation :geocode,
   :if => lambda{ |obj| obj.address.present? and obj.changed? }

  def address
    [street, city, state, country].compact.join(', ')
  end
end
