# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    return unless user.present?
    can :manage, Group, :id => Group.with_role(:admin, user).pluck(:id)
    can :manage, Accommodation, :id => Accommodation.with_role(:owner, user).pluck(:id)
    return unless user.has_role?(:admin)
    can :manage, :all
  end
end
