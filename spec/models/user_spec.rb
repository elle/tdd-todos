require "rails_helper"

describe User  do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:email) }

  describe "#invite" do
    it "sends an email invitation" do
      user = create(:user)
      allow(UserInvitationJob).to receive(:perform_later)

      user.invite

      expect(UserInvitationJob).to have_received(:perform_later)
    end
  end
end
