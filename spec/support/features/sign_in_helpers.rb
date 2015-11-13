module SignInHelpers
  def sign_in_as(email)
    visit new_session_path

    fill_in "Email", with: email
    click_button "Sign In"
  end
end

RSpec.configure do |config|
  config.include SignInHelpers
end
