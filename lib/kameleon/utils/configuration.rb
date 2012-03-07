module Kameleon
  module Utils
    module Configuration

      def self.assets_dir=(assets_dir)
        @assets_dir = assets_dir
      end

      def self.assets_dir
        @assets_dir
      end
    end
  end
end

