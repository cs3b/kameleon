module Kameleon
  module Utils
    module Configuration
      def configure
        yield self
      end
    end
  end
end
