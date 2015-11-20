class UserProfilePresenter
  attr_reader :user

  delegate :full_name, to: :user

  def initialize(user, template)
    @user = user
    @template = template
  end

  def avatar
    if user.url.present?
      h.link_to h.image_tag(avatar_name), user.url
    else
      h.image_tag(avatar_name)
    end
  end

  def title
    if user.url.present?
      h.link_to user.full_name, user.url
    else
      user.full_name
    end
  end

  private

  def h
    @template
  end

  def avatar_name
    if user.avatar_image_name.present?
      user.avatar_image_name
    else
      "default.png"
    end
  end
end
