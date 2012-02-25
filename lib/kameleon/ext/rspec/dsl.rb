require 'capybara'
require 'capybara/dsl'
require 'rspec/core'
require 'capybara/rspec/matchers'
require 'capybara/rspec/features'
require 'kameleon/dsl'

RSpec.configure do |config|
  def config.escaped_path(*parts)
    Regexp.compile(parts.join('[\\\/]'))
  end
  escaped_group_file_path = config.escaped_path(%w[spec (requests|integration)])

  config.include Capybara::DSL, :type => :request, :example_group => {:file_path => escaped_group_file_path}
  config.include Kameleon::DSL, :type => :request, :example_group => {:file_path => escaped_group_file_path}

  config.include Capybara::DSL, :type => :acceptance, :example_group => {:file_path => escaped_group_file_path}
  config.include Kameleon::DSL, :type => :acceptance, :example_group => {:file_path => escaped_group_file_path}

  config.include Capybara::RSpecMatchers, :type => :request, :example_group => {:file_path => escaped_group_file_path}
  config.include Capybara::RSpecMatchers, :type => :acceptance, :example_group => {:file_path => escaped_group_file_path}


  config.after do
    if self.class.include?(Capybara::DSL)
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
  config.before do
    if self.class.include?(Capybara::DSL)
      Capybara.current_driver = Capybara.javascript_driver if example.metadata[:js]
      Capybara.current_driver = example.metadata[:driver] if example.metadata[:driver]
    end
  end
end