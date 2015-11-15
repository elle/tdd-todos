class UsersController < ApplicationController
  def show
    user = User.find params[:id]
    @user = UserProfilePresenter.new(user, view_context)
  end
end
