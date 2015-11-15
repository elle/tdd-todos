class UserProfilePresenter
  attr_reader :user

  delegate :full_name, to: :user

  def initialize(user, template)
    @user = user
    @template = template
  end

  def github
    if user.github_name
      h.link_to user.github_name, "http://github.com/#{user.github_name}"
    else
      h.content_tag :span, "None given", class: "none"
    end
  end

  def linked_name
    h.link_to_if(user.url.present?, user.full_name, user.url)
  end

  def member_since
    user.created_at.strftime("%B %e, %Y")
  end

  private

  def avatar_name
    if user.avatar_image_name
      user.avatar_image_name
    else
      "default.png"
    end
  end

  def h
    @template
  end
end
