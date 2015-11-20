class UsersController < ApplicationController
  def show
    temp_user = User.find params[:id]
    @user = UserProfilePresenter.new(temp_user, view_context)
  end
end
