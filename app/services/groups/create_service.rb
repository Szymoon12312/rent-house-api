module Groups
  class CreateService

    def initialize(user, params)
      @params = params
      @user   = user
    end

    def self.call(user, params)
      raise ArgumentError if params.blank? || user.blank?
      new(user, params).call
    end

    def call
      create_group!
    end

    private

    attr_reader :params, :user, :group

    def assigne_group_admin!
      return user if user.add_role :admin, group
    end

    def create_group!
      @group       = Group.create!(params)
      @group.users << assigne_group_admin!
      @group.save! ? @group : nil
    end
  end
end
