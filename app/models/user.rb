class User < ActiveRecord::Base
  validates :first_name, :email, presence: true

  def full_name
    [first_name, last_name].compact.join(" ").titleize
  end
end
