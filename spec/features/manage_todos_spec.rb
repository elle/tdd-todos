require "rails_helper"

feature "Manage todos" do
  scenario "creates a new todo" do
    visit root_path
    fill_in "Email address", with: "joe@example.com"
    click_on "Sign In"
    click_link "Add a new todo"
    fill_in "Description", with: "Buy milk"
    click_button "Create todo"

    expect(page).to have_css("li.todo", text: "Buy milk")
  end
end
