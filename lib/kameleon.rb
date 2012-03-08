require 'kameleon/utils/configuration'

module Kameleon
  def self.configure(&block)
    yield(Kameleon::Utils::Configuration)
  end
end
