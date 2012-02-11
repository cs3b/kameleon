module Kameleon
  module Utils
    module Configuration
      #! configuration
      def configure
        yield self
      end
    end
  end
end

