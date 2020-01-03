module Api
  class RentRequestSerializer < ActiveModel::Serializer
    attributes :id, :status
    belongs_to :accommodation, serializer: AccommodationSerializer
    belongs_to :user, serializer: UserSerializer
    belongs_to :group, serializer: GroupSerializer
  end
end
