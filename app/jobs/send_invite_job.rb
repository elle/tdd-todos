class SendInviteJob < ActiveJob::Base
  queue_as :default

  def perform(user_id)
    UserInvitation.new_invite(user_id).deliver_now
  end
end
