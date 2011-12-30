require 'spec_helper'

RSpec.configure do |config|
  config.before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end
end
