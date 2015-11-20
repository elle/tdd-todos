require "rails_helper"

describe User  do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:email) }

  describe "#invite" do
    it "calls on SendInviteJob" do
      user = build(:user)
      allow(SendInviteJob).to receive(:perform_later)

      user.invite

      expect(SendInviteJob).to have_received(:perform_later)
    end
  end
end
