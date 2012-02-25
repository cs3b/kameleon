require 'headless'

RSpec.configure do |config|
  config.before(:suite) do
    @headless = Headless.new(:display => '100')
    @headless.start
  end

  config.after(:suite) do
    @headless.stop if defined?(@headless)
  end
end