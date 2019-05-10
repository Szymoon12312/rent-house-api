module Groups
  class AddUserService

    def initialize(group, user)
      @group = group
      @user = user
    end

    def self.call(group, user)
      raise ArgumentError if uuid.blank? or user.blank?
      new(group, user).call
    end

    def call
      add_user
    end

    private

    attr_accessor :group, :user

    def add_user
      raise Error::UserAlredyInGroupError if  user.in?(group.users)
      group.users << user
    end

  end
end
