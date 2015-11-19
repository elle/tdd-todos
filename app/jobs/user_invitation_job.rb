class UserInvitationJob < ActiveJob::Base
  queue_as :default

  def perform(user_id)
    InvitationMailer.new_invite(user_id).deliver_now
  end
end
