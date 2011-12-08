module Kameleon
  module User
    class Abstract
      attr_accessor :rspec_world
      attr_accessor :session


      def change_session(session_name)
        @session = find_or_create_session(session_name) ||
            current_session
      end

      private

      def find_or_create_session(session_name)
        find_session(session_name) ||
            create_session(session_name)
      end

      def find_session(session_name)
        session_pool[session_name]
      end

      def create_session(session_name)
        Capybara::Session.new(Capybara.current_driver, Capybara.app).tap do |session|
          session_pool[session_name] = session
        end if session_name
      end

      def session_pool
        Capybara.send(:session_pool)
      end

      def current_session
        Capybara.current_session
      end

    end
  end
end