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

  def bio
    if user.bio
      markdown.render(user.bio)
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

  def title
    if user.url.present?
      h.link_to user.full_name, user.url
    else
      user.full_name
    end
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

  def h
    @template
  end

  def markdown
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, auto_link: true)
  end
end
