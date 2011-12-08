module Kameleon
  module User
    class Guest < Abstract
      def initialize(rspec_world, options={})
        @rspec_world = rspec_world
        @driver_name = options.delete(:driver)
        @session_name = options.delete(:session_name)
        @options = options
        set_session
        session.visit('/') if load_homepage?
      end
    end
  end
end