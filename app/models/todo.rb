class Todo < ActiveRecord::Base
  def user=(user)
    self.owner_email = user.email
  end
end
