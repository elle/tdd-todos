class User < ActiveRecord::Base
  validates :first_name, :email, presence: true

  def full_name
    [first_name, last_name].compact.join(" ").titleize
  end

  def member_since
    created_at.strftime("%B %e, %Y")
  end
end
