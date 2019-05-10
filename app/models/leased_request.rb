class LeasedRequest < ApplicationRecord
  belongs_to :group, optional: true
  belongs_to :user, optional: true
  belongs_to :accommodation, dependent: :destroy

  validates :status, acceptance: { accept: ['rejected', 'accepted','pending'] }

  scope :pending,            -> { where(status: 'pending') }
  scope :accepted,           -> { where(status: 'accepted') }
  scope :with_expaired_date, -> { where("created_at <= ? AND status = 'pending'", Time.now - 1.day) }
end
