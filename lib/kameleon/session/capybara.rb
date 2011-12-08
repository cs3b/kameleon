module Kameleon
  module Session
    module Capybara
      def change_session(session_name, driver_name)
        @session = find_or_create_session(session_name, driver_name) ||
            current_session
      end

      private

      def find_or_create_session(session_name, driver_name)
        find_session(session_name) ||
            create_session(session_name, driver_name)
      end

      #! in future we should print notice when selected drive is different then session that have been chosen
      def find_session(session_name)
        session_pool[session_name]
      end

      def create_session(session_name, driver_name)
        ::Capybara::Session.new(current_driver(driver_name), ::Capybara.app).tap do |session|
          session_pool[session_name] = session
        end if session_name
      end

      def session_pool
        ::Capybara.send(:session_pool)
      end

      def current_session
        ::Capybara.current_session
      end

      def current_driver(driver_name)
        driver_name ||
            ::Capybara.current_driver
      end
    end
  end
end