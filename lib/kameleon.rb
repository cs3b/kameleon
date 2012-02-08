require 'kameleon/session/capybara'
require 'kameleon/dsl/see'
require 'kameleon/dsl/act'

require 'kameleon/user/abstract'
require 'kameleon/user/base'
require 'kameleon/user/guest'

require 'kameleon/utils/configuration'
require 'kameleon/utils/helpers'

module Kameleon
  extend Utils::Configuration
  extend Utils::Helpers

  class << self
    attr_accessor :default_file_path

    def default_file_path=(path)
      @default_file_path = File.expand_path(path)
    end
  end
end

# Set up default configuration for Kameleon
Kameleon.configure do |config|
  config.default_file_path = 'spec/dummy'
end
