require "rails_helper"

describe ApplicationController do
  it "redirects instead of showing a 404 page" do
    should rescue_from(ActiveRecord::RecordNotFound).with(:handle_not_found)
  end
end
