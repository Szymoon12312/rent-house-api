class AccommodationLeased < ApplicationRecord
  belongs_to :accommodation
  belongs_to :group, foreign_key: :renter_group_id, optional: true
  belongs_to :price
  belongs_to :user, foreign_key: :renter_id, optional: true

  validates_presence_of :leased_from, :leased_to, :accommodation, :price
  validate :user_or_group

  private

  def user_or_group
    errors.add(:client_id, "Either User or Group needs a value") unless renter_id.present? || renter_group_id.present?
  end
end
