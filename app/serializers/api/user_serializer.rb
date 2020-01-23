module Api
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :groups
  end
end
