require "rails_helper"

feature "View homepage" do
  scenario "user sees relevant information" do
    visit root_path

    expect(page).to have_title "Todos"
    expect(page).to have_css '[data-role="description"]', text: "Todos"
  end
end
