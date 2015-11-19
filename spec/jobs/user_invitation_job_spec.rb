require "rails_helper"

describe UserInvitationJob do
  describe "perform" do
    it "calls on InvitationMailer" do
      user = create(:user)
      allow(InvitationMailer).
        to receive_message_chain(:new_invite, :deliver_now)

      UserInvitationJob.new.perform(user.id)

      expect(InvitationMailer).to have_received(:new_invite)
    end

    it "queues the job" do
      user = create(:user)
      allow(InvitationMailer).
        to receive_message_chain(:new_invite, :deliver_now)

      UserInvitationJob.perform_later(user.id)

      expect(Delayed::Job.all).not_to be_empty
      expect(Delayed::Job.all.count).to eq 1
    end
  end
end
