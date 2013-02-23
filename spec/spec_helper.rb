require 'kameleon'
require 'kameleon/ext/rspec/all'
require 'capybara/webkit'
require 'pry'
require 'capybara/poltergeist'

Dir["#{File.expand_path("../", __FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end

Capybara.configure do |c|
  c.default_driver= (ENV['CAPYBARA_DEFAULT_DRIVER']||:rack_test).to_sym
end

Kameleon.configure do |c|
  c.assets_dir = File.join(File.expand_path("../", __FILE__), 'fixtures', 'assets')
end
