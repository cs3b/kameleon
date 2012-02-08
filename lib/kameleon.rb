require 'kameleon/utils/configuration'
require 'kameleon/utils/helpers'

require 'kameleon/session/capybara'
require 'kameleon/dsl/see'
require 'kameleon/dsl/act'

require 'kameleon/user/abstract'
require 'kameleon/user/base'
require 'kameleon/user/guest'


module Kameleon
  extend Utils::Configuration
end

# Set up default configuration for Kameleon
Kameleon.configure do |config|
  config.default_file_path = 'spec/dummy'
end
