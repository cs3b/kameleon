module Kameleon
  module Session
    module Capybara

      attr_accessor :session_name
      attr_accessor :driver_name

      def set_session
        @session = find_or_create_session ||
            current_session
      end

      private

      def find_or_create_session
        find_session ||
            create_session
      end

      #! in future we should print notice when selected drive is different then session that have been chosen
      def find_session
        session_pool[session_name]
      end

      def create_session
        ::Capybara::Session.new(current_driver, ::Capybara.app).tap do |session|
          session_pool[session_name] = session
        end if session_name
      end

      def session_pool
        ::Capybara.send(:session_pool)
      end

      def current_session
        ::Capybara.current_session
      end

      def current_driver
        driver_name ||
            ::Capybara.current_driver
      end
    end
  end
end