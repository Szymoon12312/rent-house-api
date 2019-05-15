class AccommodationLeased < ApplicationRecord
  belongs_to :accommodation
  belongs_to :group
  belongs_to :price
  belongs_to :user
end
