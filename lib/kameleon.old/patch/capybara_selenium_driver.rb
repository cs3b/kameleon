class Capybara::Selenium::Driver
  def initialize(app, options={})
    @app = app
    @options = DEFAULT_OPTIONS.merge(options)
    @rack_server = ::Kameleon::Session::Server.server(app)
  end
end