module Kameleon
  module Utils
    module Configuration
      attr_accessor :default_file_path

      def configure
        yield self
      end

      def default_file_path=(path)
        @default_file_path = File.expand_path(path)
      end
    end
  end
end
