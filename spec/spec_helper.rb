require 'kameleon'
require 'kameleon/ext/rspec/all'
require 'capybara/webkit'

Dir["#{File.expand_path("../", __FILE__)}/support/**/*.rb"].each { |f| require f }

Capybara.configure do |c|
  c.default_driver= (ENV['CAPYBARA_DEFAULT_DRIVER']||:rack_test).to_sym
end

Kameleon.configure do |c|
  c.assets_dir = File.join(File.expand_path("../", __FILE__), 'fixtures', 'assets')
end
