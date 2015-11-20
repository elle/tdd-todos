require "rails_helper"

describe UserProfilePresenter do
  subject { described_class.new(double, view) }

  it { should delegate_method(:full_name).to(:user) }

  it "can be initialized" do
    user = double

    expect { subject }.not_to raise_error
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
end
