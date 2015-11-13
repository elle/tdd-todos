require "rails_helper"

describe TodosController do
  context "create" do
    it "fails elegantly" do
      post :create, todo: {}

      expect(flash["warning"]).to eq "Cannot create todo"
      expect(response).to redirect_to root_path
    end
  end
end
