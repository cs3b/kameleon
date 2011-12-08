module Kameleon
  module User
    class Guest < Abstract
      def initialize(rspec_world, options={})
        @rspec_world = rspec_world
        change_session(options.delete(:session_name), options.delete(:driver))
      end
    end
  end
end