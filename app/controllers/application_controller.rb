class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authenticate
    if current_email.blank?
      redirect_to new_session_path, notice: "Must be logged in"
    end
  end

  def sign_in(email)
    session[:current_email] = email
  end

  def current_email
    session[:current_email]
  end
  helper_method :current_email

  def twilio_client
    @twilio_client ||= ENV["SMS_CLASS"].constantize.new(
      ENV.fetch("TWILIO_ACCOUNT_ID"),
      ENV.fetch("TWILIO_ACCOUNT_TOKEN"),
    )
  end
end
