require 'rails_helper'

describe SendInviteJob do
  describe "#perform" do
    it "calls on InvitationMailer" do
      user = create(:user)
      allow(UserInvitation).to receive_message_chain(:new_invite, :deliver_now)

      SendInviteJob.new.perform(user.id)

      expect(UserInvitation).to have_received(:new_invite)
    end
  end

  describe "#perform_later" do
    it "adds the job to the queue" do
      user = create(:user)
      allow(UserInvitation).to receive_message_chain(:new_invite, :deliver_now)

      SendInviteJob.perform_later(user.id)

      expect(Delayed::Job.all.count).to eq 1
    end
  end
end
