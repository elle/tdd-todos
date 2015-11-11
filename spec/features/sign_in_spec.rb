require "rails_helper"

feature "User signs in" do
  scenario "with an email" do
    visit root_path

    fill_in "Email address", with: "joe@example.com"
    click_on "Sign In"

    expect(page).to have_css(".welcome", text: "Welcome joe@example.com")
  end
end
