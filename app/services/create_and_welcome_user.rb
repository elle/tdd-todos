class CreateAndWelcomeUser
  def initialize(user_params)
    @user_params = user_params
  end

  def call
    if user.save
      user.invite
    end

    user
  end

  private

  attr_reader :user_params

  def user
    @user = User.new(user_params)
  end
end
