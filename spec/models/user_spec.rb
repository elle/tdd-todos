require "rails_helper"

describe User do
  context "#email" do
    it "returns the email the user was instantiated with" do
      user = User.new("joe@example.com")

      expect(user.email).to eq "joe@example.com"
    end
  end

  context "#todos" do
    it "returns todos whose owner_email match the user's email" do
      Todo.delete_all

      todo1 = Todo.create(description: "Buy milk", owner_email: "joe@example.com")
      todo2 = Todo.create(description: "Buy milk", owner_email: "other@example.com")

      user = User.new("joe@example.com")

      expect(user.todos).to eq [todo1]
    end
  end
end
