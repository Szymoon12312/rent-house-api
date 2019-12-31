class Price < ApplicationRecord
  belongs_to :accommodation
  has_many :accommodation_leaseds, dependent: :destroy

  before_create :set_valid_term

  private

  def set_valid_term #Valid for 1 year
    self.valid_from = Time.current
    self.valid_to   = 1.year.from_now
  end

end
