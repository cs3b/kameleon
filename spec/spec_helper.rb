require 'kameleon'
require 'capybara/dsl'
require 'capybara/rspec/matchers'

Dir["#{File.expand_path("../", __FILE__)}/support/**/*.rb"].each { |f| require f }

require 'sample_rack_app/hey'

RSpec.configure do |config|
  Capybara.default_driver = :selenium

  config.before(:all) do
    DeferredGarbageCollection.start
  end

  config.after(:all) do
    DeferredGarbageCollection.reconsider
  end
end
