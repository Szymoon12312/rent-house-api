class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  rolify

  has_many :user_groups
  has_many :groups, :through => :user_groups, dependent: :destroy
  has_many :accommodations, dependent: :destroy
end

