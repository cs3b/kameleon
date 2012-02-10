require 'singleton'
module Kameleon
  module Session
    class Server
      include ::Singleton
      class << self
        def server(app)
          @server ||= start_new_server(app)
        end

        private

        def start_new_server(app)
          rack_server = ::Capybara::Server.new(app)
          rack_server.boot
          rack_server
        end
      end
    end
  end
end
