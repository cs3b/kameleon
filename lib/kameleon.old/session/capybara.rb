module Kameleon
  module Session
    module Capybara
      attr_accessor :driver_name

      def set_session
        @session = ::SessionPool.session(current_driver)
      end

      def refresh_page
        case session.driver.class.name
          when 'Capybara::Selenium::Driver', 'Capybara::RackTest::Driver'
            visit session.driver.browser.current_url
          when 'Capybara::Culerity::Driver'
            session.driver.browser.refresh
          else
            raise 'unsupported driver'
        end
      end

      private

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