class Group < ApplicationRecord
  resourcify

  has_many :user_groups
  has_many :users, through: :user_groups, dependent: :destroy
  has_many :accommodation_leaseds, foreign_key: :renter_group_id
end
