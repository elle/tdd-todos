class UserProfilePresenter
  attr_reader :user

  delegate :full_name, to: :user

  def initialize(user, template)
    @user = user
    @template = template
  end

  def avatar
    h.link_to_if(
      user.url.present?,
      h.image_tag("avatars/#{avatar_name}", class: "avatar"),
      user.url
    )
  end

  def bio
    if user.bio
      user.bio
    else
      h.content_tag :span, "None given", class: "none"
    end
  end

  def github
    handle_none user.github_name do
      h.link_to user.github_name, "http://github.com/#{user.github_name}"
    end
  end

  def linked_name
    h.link_to_if(user.url.present?, user.full_name, user.url)
  end

  def member_since
    user.created_at.strftime("%B %e, %Y")
  end

  def twitter
    handle_none user.twitter_name do
      h.link_to user.twitter_name, "http://twitter.com/#{user.twitter_name}"
    end
  end

  def website
    handle_none user.url do
      h.link_to user.url, user.url
    end
  end

  private

  def avatar_name
    if user.avatar_image_name
      user.avatar_image_name
    else
      "default.png"
    end
  end

  def handle_none(value)
    if value.present?
      yield
    else
      h.content_tag :span, "None given", class: "none"
    end
  end

  def h
    @template
  end
end
