class User < ApplicationRecord
  rolify

  has_many :user_groups
  has_many :groups, :through => :user_groups
  has_many :accommodations

  # checking
  def is_group_admin?
    self.has_role?('group_admin')
  end

  def is_owner?
    self.has_role?('owner')
  end

  # changing
  def add_new_role(role)
    self.update_attributes(accepted_at: Time.now) if self.is_only_potential?
    self.add_role(role)
  end

  def make_group_admin!
    add_new_role('group_admin')
  end

  def denounce_group_admin!
    remove_role('group_admin')
  end
end

