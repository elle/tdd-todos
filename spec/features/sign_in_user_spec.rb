require "rails_helper"

feature "sign in user" do
  scenario "with email" do
    visit new_session_path

    fill_in "Email", with: "alpha@example.com"
    click_on "Sign In"

    expect(page).to have_content("Successfully signed in")
    expect(page).to have_content("Welcome, alpha@example.com")
  end
end
