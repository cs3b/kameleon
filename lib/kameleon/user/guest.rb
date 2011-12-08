module Kameleon
  module User
    class Guest < Abstract
      def initialize(rspec_world, options={})
        @rspec_world = rspec_world
        change_session(options.delete(:session_name))
      end
    end
  end
end