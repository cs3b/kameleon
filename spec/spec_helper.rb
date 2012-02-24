require 'capybara/dsl'
require 'capybara/rspec/matchers'

# require 'kameleon/ext/rspec/all'
require 'kameleon/ext/active_record/shared_single_connection'
require 'kameleon/ext/rspec/headless'
require 'kameleon/ext/rspec/defered_garbage_collector'
require 'kameleon/ext/rspec/session_pool'
require 'kameleon/ext/rspec/dsl'

Dir["#{File.expand_path("../", __FILE__)}/support/**/*.rb"].each { |f| require f }


dummy_app_path = File.join(File.expand_path("../../", __FILE__), 'dummy_app', 'app', 'dummy_app.rb')
require dummy_app_path
Capybara.app = Hey.new

RSpec.configure do |config|
  config.before(:suite) do
    @headless = Headless.new(:display => '100')
    @headless.start
  end

  config.before(:all) do
    DeferredGarbageCollection.start
  end

  config.after(:each) do
    ::SessionPool.release_all
  end

  config.after(:all) do
    DeferredGarbageCollection.reconsider
  end

  config.after(:suite) do
    @headless.stop if defined?(@headless)
  end
end

Capybara.configure do |c|
  c.default_driver= (ENV['CAPYBARA_DEFAULT_DRIVER']||:rack_test).to_sym
end
