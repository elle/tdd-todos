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

  def twitter
    if user.twitter_name
      h.link_to user.twitter_name, "http://twitter.com/#{user.twitter_name}"
    else
      h.content_tag :span, "None given", class: "none"
    end
  end

  def website
    if user.url
      h.link_to user.url, user.url
    else
      h.content_tag :span, "None given", class: "none"
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

  def h
    @template
  end
end
