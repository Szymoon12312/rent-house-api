class LeasedRequest < ApplicationRecord
  belongs_to :group, optional: true
  belongs_to :user, optional: true
  belongs_to :accommodation, dependent: :destroy

  validates :status, acceptance: { accept: ['rejected', 'accepted', 'pending', 'canceled'] }
  validates :user_or_group

  scope :pending,            -> { where(status: 'pending') }
  scope :accepted,           -> { where(status: 'accepted') }
  scope :with_expaired_date, -> { where("created_at <= ? AND status = 'pending'", Time.now - 2.day) }
  scope :for_user,           -> (current_user) { where(user: current_user) }

  private

  def user_or_group
    errors.add(:client_id, "Either User or Group needs a value") unless user_id.present? || group_id.present?
  end
end
