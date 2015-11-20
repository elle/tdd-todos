require "rails_helper"

describe CreateAndWelcomeUser do
  it "can be initialized with user params" do
    user_params = attributes_for(:user)

    expect do
      CreateAndWelcomeUser.new(user_params)
    end.not_to raise_error
  end

  describe "#call" do
    it "saves a user" do
      user_params = attributes_for(:user)

      expect do
        described_class.new(user_params).call
      end.to change(User, :count).by(1)
    end

    it "invites a new user" do
      user_params = { first_name: "John", email: "john@example.com" }
      allow(SendInviteJob).to receive(:perform_later)

      CreateAndWelcomeUser.new(user_params).call

      expect(SendInviteJob).to have_received(:perform_later)
    end

    it "doesn't save user if invalid" do
      allow(SendInviteJob).to receive(:perform_later)

      result = CreateAndWelcomeUser.new({}).call

      expect(SendInviteJob).not_to have_received(:perform_later)
      #expect(result.errors.messages[:first_name]).to include "can't be blank"
    end

    it "returns the user" do
      user_params = attributes_for(:user)

      result = CreateAndWelcomeUser.new(user_params).call

      expect(result).to be_kind_of(User)
    end
  end
end
