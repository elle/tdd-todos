require "rails_helper"

feature "send SMS to user" do
  scenario "when creating a new todo" do
    sign_in_as "alpha@example.com"
    visit root_path
    fill_in "Description", with: "I have sent an SMS"
    click_button "Create todo"

    last_message = FakeSMS.messages.last
    expect(last_message.body).to eq "I have sent an SMS"
    expect(last_message.from).to eq ENV.fetch("TWILIO_FROM_NUMBER")
  end
end
