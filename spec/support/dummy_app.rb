Dir[File.join(File.expand_path("../../../", __FILE__), 'dummy_app', 'app', '*.rb')].each do |file|
  require file
end
Capybara.app = DummyApp.new