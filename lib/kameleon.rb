require 'kameleon/utils/configuration'

module Kameleon
  class NotImplementedException < StandardError; end

  def self.configure(&block)
    yield(Kameleon::Utils::Configuration)
  end
end
