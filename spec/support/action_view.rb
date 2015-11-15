RSpec.configure do |config|
  config.include(ActionView::TestCase::Behavior, file_path: %r{spec/presenters})
end
