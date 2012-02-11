require 'kameleon'
require 'capybara/dsl'
require 'capybara/rspec/matchers'

require 'capybara/selenium/driver'
# one server on all sessions for selenium
# require 'patch/capybara_selenium_driver'
require 'headless'

Dir["#{File.expand_path("../", __FILE__)}/support/**/*.rb"].each { |f| require f }

require 'sample_rack_app/hey'

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

Capybara.app = Hey.new

Capybara.configure do |c|
  c.default_driver= (ENV['CAPYBARA_DEFAULT_DRIVER']||:rack_test).to_sym
end
