module Error
  class UserAlredyInGroupError < CustomError
    def initialize
      super(_message: 'User alredy in group')
    end
  end
end
