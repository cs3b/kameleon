require 'kameleon/ext/capybara/session_pool'

RSpec.configure do |config|
  config.after(:each) do
    Kameleon::Ext::Capybara::SessionPool.release_all
  end
end