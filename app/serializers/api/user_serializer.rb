module Api
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :email
  end
end
