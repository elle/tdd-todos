require 'rails_helper'

describe Todo do
  describe "#user=" do
    it "assigns owner_email from the user" do
      user = User.new("joe@example.com")
      todo = Todo.new
      todo.user = user

      expect(todo.owner_email).to eq "joe@example.com"
    end
  end
end
