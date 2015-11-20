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
    handle_none user.bio do
      markdown.render(user.bio)
    end
  end

  def github
    handle_none user.github_name do
      h.link_to user.github_name, "http://github.com/#{user.github_name}"
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

  def handle_none(value)
    if value.present?
      yield
    else
      h.content_tag :span, "None given", class: "none"
    end
  end
end









