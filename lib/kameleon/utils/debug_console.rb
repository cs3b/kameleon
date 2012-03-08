#! TODO
# gemfile
# gem 'ripl'
# gem 'database-cleaner'

# spec_helper.rb
# if we use spork (drb) we need to (before environment is loaded)
require 'active_record'

class ActiveRecord::Base
  include DRb::DRbUndumped
end

# config debug console
require 'database_cleaner'
DatabaseCleaner.strategy = :transaction


RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    if exception = example.instance_variable_get(:@exception)
      save_and_open_page unless Capybara.current_driver == :selenium
      Ripl.start :binding => binding
    end
    DatabaseCleaner.clean
  end
end
