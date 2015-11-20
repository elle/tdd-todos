require "ostruct"

class FakeSMS
  Message = OpenStruct

  cattr_accessor :messages
  self.messages = []

  def initialize(_account_id, _account_token)
  end

  def messages
    self
  end

  def create(from:, to:, body:)
    self.class.messages << OpenStruct.new(from: from, to: to, body: body)
  end
end
