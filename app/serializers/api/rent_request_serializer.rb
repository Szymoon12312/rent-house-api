module Api
  class RentRequestSerializer < ActiveModel::Serializer
    belongs_to :accommodation
    belongs_to :user
    belongs_to :group
  end
end
