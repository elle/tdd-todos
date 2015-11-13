class SessionsController < ApplicationController
  def new
  end

  def create
    session[:email] = params[:sessions][:email]
    flash[:notice] = "Successfully signed in"
    redirect_to root_path
  end
end
