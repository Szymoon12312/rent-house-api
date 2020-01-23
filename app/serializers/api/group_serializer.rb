module Api
  class GroupSerializer < ActiveModel::Serializer
    attributes :name
    has_many :users, serializer: UserSerializer
  end
end
