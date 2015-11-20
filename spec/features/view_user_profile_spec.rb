require "rails_helper"

feature "views user profile" do
  scenario "successfully" do
    user = create(:user)
    visit user_path(user)

    expect(page).to have_content user.first_name
    expect(page).to have_selector "img[src='/images/default.png']"
  end
end
