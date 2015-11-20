require "rails_helper"

describe UserProfilePresenter do
  subject { described_class.new(double, view) }

  it { should delegate_method(:full_name).to(:user) }

  describe "#avatar" do
    context "when avatar_image_name exists" do
      context "when url is present" do
        it "displays image with link" do
          user = double(url: "abc", avatar_image_name: "edf.jpg")
          html = "<a href=\"abc\"><img src=\"/images/edf.jpg\" alt=\"Edf\" /></a>"

          presenter = described_class.new(user, view)

          expect(presenter.avatar).to eq html
        end
      end

      context "when url is not present" do
        it "displays image" do
          user = double(url: nil, avatar_image_name: "edf.jpg")
          html = "<img src=\"/images/edf.jpg\" alt=\"Edf\" />"

          presenter = described_class.new(user, view)

          expect(presenter.avatar).to eq html
        end
      end
    end

    context "when avatar_image_name does not exist" do
      it "default to default image" do
        user = double(url: nil, avatar_image_name: nil)
        html = "<img src=\"/images/default.png\" alt=\"Default\" />"

        presenter = described_class.new(user, view)

        expect(presenter.avatar).to eq html
      end
    end
  end
  context "#bio" do
    it "says when none given" do
      user = double(bio: nil)
      presenter = described_class.new(user, view)
      html = '<span class="none">None given</span>'

      expect(presenter.bio).to eq html
    end

    it "parses markdown" do
      user = double(bio: "abc")
      presenter = described_class.new(user, view)
      html = "<p>abc</p>\n"

      expect(presenter.bio).to eq html
    end
  end

  context "#github" do
    it "says when none given" do
      user = double(github_name: nil)
      presenter = described_class.new(user, view)
      html = '<span class="none">None given</span>'

      expect(presenter.github).to eq html
    end

    it "links to github page" do
      user = double(github_name: "abc")
      presenter = described_class.new(user, view)
      html = '<a href="http://github.com/abc">abc</a>'

      expect(presenter.github).to eq html
    end
  end

  describe "#title" do
    context "when url is present" do
      it "links to user" do
        user = double(url: "abc", full_name: "John")
        html = "<a href=\"abc\">John</a>"

        presenter = described_class.new(user, view)

        expect(presenter.title).to eq html
      end
    end

    context "when url is not present" do
      it "displays user full_name" do
        user = double(url: nil, full_name: "John")

        presenter = described_class.new(user, view)

        expect(presenter.title).to eq "John"
      end
    end
  end

  context "#twitter" do
    it "says when none given" do
      user = double(twitter_name: nil)
      presenter = described_class.new(user, view)
      html = '<span class="none">None given</span>'

      expect(presenter.twitter).to eq html
    end

    it "links to twitter page" do
      user = double(twitter_name: "abc")
      presenter = described_class.new(user, view)
      html = '<a href="http://twitter.com/abc">abc</a>'

      expect(presenter.twitter).to eq html
    end
  end

  context "#website" do
    it "says when none given" do
      user = double(url: nil)
      presenter = described_class.new(user, view)
      html = '<span class="none">None given</span>'

      expect(presenter.website).to eq html
    end

    it "links to website" do
      user = double(url: "example.com")
      presenter = described_class.new(user, view)
      html = '<a href="example.com">example.com</a>'

      expect(presenter.website).to eq html
    end
  end
end
