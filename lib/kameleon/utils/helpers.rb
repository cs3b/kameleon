module Kameleon
  module Utils
    module Helpers
      def default_path_for_file(file_name)
        File.join(Kameleon.default_file_path, file_name)
      end
    end
  end
end
