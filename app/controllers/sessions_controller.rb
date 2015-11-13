class SessionsController < ApplicationController
  def new
  end

  def create
    sign_in params[:sessions][:email]

    flash[:notice] = "Successfully signed in"
    redirect_to root_path
  end
end
