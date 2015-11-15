require "rails_helper"

describe UsersController do
  describe "show" do
    context "when user not found" do
      it "redirects to root_path" do
        get :show, id: 123

        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eq "Not found"
      end
    end
  end
end
