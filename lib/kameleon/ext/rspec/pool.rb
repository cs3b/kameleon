require 'kameleon/ext/capybara/session_pool'

RSpec.configure do |config|
  config.after(:each) do
    ::SessionPool.release_all
  end
end