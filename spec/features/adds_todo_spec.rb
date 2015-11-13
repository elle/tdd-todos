require "rails_helper"

feature "A user adds todos" do
  scenario "successfully" do
    visit root_path
    fill_in "Description", with: "Tweet"
    click_button "Create todo"

    expect(page).to have_content("created a todo successfully")
    expect(page).to have_content("Tweet")
  end
end
