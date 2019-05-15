class Group < ApplicationRecord
  resourcify

  has_many :user_groups
  has_many :users, through: :user_groups, dependent: :destroy
end
