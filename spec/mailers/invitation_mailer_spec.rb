require "rails_helper"

describe InvitationMailer do
  it "sets the subject correctly" do
    user = create(:user)

    InvitationMailer.new_invite(user.id).deliver_now

    expect(last_email.subject).to eq("Welcome")
  end

  it "renders the email with user's name" do
    user = create(:user)

    InvitationMailer.new_invite(user.id).deliver_now

    expect(last_email.body).to include(user.first_name)
  end

  it "send it to the right email address" do
    user = create(:user)

    InvitationMailer.new_invite(user.id).deliver_now

    expect(last_email.to).to include(user.email)
  end
end
