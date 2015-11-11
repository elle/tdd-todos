require "rails_helper"

feature "Manage todos" do
  scenario "creates a new todo" do
    sign_in_as "joe@example.com"
    create_todo_with_description("Buy milk")

    expect(page).to have_css("li.todo", text: "Buy milk")
  end

  scenario "view only my todos" do
    create(:todo, description: "Buy eggs", owner_email: "not_me@example.com")

    sign_in_as "joe@example.com"
    create_todo_with_description("Buy milk")

    expect(page).to have_css("li.todo", text: "Buy milk")
    expect(page).not_to have_css("li.todo", text: "Buy eggs")
  end

  scenario "mark todos as complete" do
    sign_in_as "joe@example.com"
    create_todo_with_description "Buy some milk"

    within "li.todo" do
      click_link "Complete"
    end

    expect(page).to have_css "li.todo.completed"
  end

  private

  def create_todo_with_description(description)
    click_link "Add a new todo"
    fill_in "Description", with: description
    click_button "Create todo"
  end
end
