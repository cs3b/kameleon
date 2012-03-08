dummy_app_path = File.join(File.expand_path("../../../", __FILE__), 'dummy_app', 'app', 'dummy_app.rb')
require dummy_app_path
Capybara.app = DummyApp.new