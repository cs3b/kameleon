require 'singleton'

module Kameleon
  module Capybara
    class SessionPool
      include Singleton
      class << self
        attr_writer :nice

        def session(driver)
          take_idle(driver) || create(driver)
        end

        def release_all
          idle.concat(busy)
          busy.clear
        end

        protected

        def idle
          @idle ||= []
        end

        def busy
          @busy ||= []
        end

        def take_idle(driver)
          if session = find_idle(driver)
            session.reset!
            session.tap do |s|
              idle.delete(s)
              busy.push(s)
            end
          end
        end

        def find_idle(driver)
          idle.detect { |session| session.mode == driver }
        end

        def create(driver)
          ::Capybara::Session.new(driver, ::Capybara.app).tap do |session|
            busy.push(session)
          end
        end
      end
    end
  end
end