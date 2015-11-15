require "rails_helper"

describe UserProfilePresenter do
  subject { described_class.new(double(full_name: "John"), view) }

  it { is_expected.to delegate_method(:full_name).to(:user) }

  it "is initialized" do
    expect do
      described_class.new(double, view)
    end.not_to raise_error
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

  context "#linked_name" do
    context "when there is no url" do
      it "just displays full_name" do
        user = double(full_name: "John", url: nil)
        presenter = described_class.new(user, view)

        expect(presenter.linked_name).to eq "John"
      end
    end

    context "when there is a url" do
      it "links to user's website" do
        user = double(full_name: "John", url: "example.com")
        presenter = described_class.new(user, view)
        html = '<a href="example.com">John</a>'

        expect(presenter.linked_name).to eq html
      end
    end
  end

  context "#member_since" do
    it "displays as month, day, year" do
      time = Time.current
      user = double(created_at: time)
      presenter = described_class.new(user, view)

      expect(presenter.member_since).to eq time.strftime("%B %e, %Y")
    end
  end
end
