require "rails_helper"

describe TodosController do
  context "create" do
    it "fails elegantly" do
      session[:current_email] = "alpha@example.com"

      post :create, todo: {}

      expect(flash["warning"]).to eq "Cannot create todo"
      expect(response).to redirect_to root_path
    end
  end
end
