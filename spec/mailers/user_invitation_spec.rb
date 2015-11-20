require "rails_helper"

describe UserInvitation do
  describe "#new_invite" do
    it "sets the subject correctly" do
      user = create(:user)

      UserInvitation.new_invite(user.id).deliver_now

      expect(last_email.subject).to eq "Welcome"
    end

    it "renders the email with user's name" do
      user = create(:user)

      UserInvitation.new_invite(user.id).deliver_now

      expect(last_email.body).to include(user.first_name)
    end

    it "sends it to the right email address" do
      user = create(:user)

      UserInvitation.new_invite(user.id).deliver_now

      expect(last_email.to).to include user.email
    end
  end
end
