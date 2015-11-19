require "rails_helper"

describe CreateAndWelcomeUser do
  describe "#call" do
    it "saves a new user" do
      user_params = attributes_for(:user)
      create_user = described_class.new(user_params)

      expect { create_user.call }.to change(User, :count).by(1)
    end

    it "invites a new user" do
      user_params = attributes_for(:user)
      allow(UserInvitationJob).to receive(:perform_later)

      CreateAndWelcomeUser.new(user_params).call

      expect(UserInvitationJob).to have_received(:perform_later)
    end

    it "doesn't save user if not valid" do
      create_user = described_class.new({})

      expect { create_user.call }.not_to change(User, :count)
    end

    it "returns the user" do
      result = described_class.new({}).call

      expect(result).to be_kind_of(User)

      expect(result.errors).not_to be_empty
      expect(result.errors.messages[:first_name]).to include "can't be blank"
    end
  end
end

