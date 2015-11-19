class InvitationMailer < ApplicationMailer
  def new_invite(user_id)
    @user = User.find(user_id)

    mail(to: @user.email, subject: "Welcome",)
  end
end
