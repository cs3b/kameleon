require 'singleton'

module Kameleon
  module Ext
    module Capybara
      class SessionPool
        include Singleton
        class << self
          attr_writer :nice

          def session(driver, name = :default)
            (take_idle(driver) || create(driver)).tap do |session|
              attach_to_capybara_session_pool(driver, name, session)
            end
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

          def attach_to_capybara_session_pool(driver, name, session)
            capybara_session_pool["#{driver}:#{name}:#{::Capybara.app.object_id}"] = session
          end

          def capybara_session_pool
            ::Capybara.send(:session_pool)
          end
        end
      end
    end
  end
end