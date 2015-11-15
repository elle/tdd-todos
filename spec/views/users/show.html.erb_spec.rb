require "rails_helper"

describe "users/show.html.erb" do
  it "displays user's profile" do
    user = build(:user, first_name: "John", created_at: Time.current)
    assign(:user, UserProfilePresenter.new(user, view))

    render

    expect(rendered).to match /John/
    expect(rendered).to have_selector "img[src='/assets/avatars/default.png']"
  end
end
