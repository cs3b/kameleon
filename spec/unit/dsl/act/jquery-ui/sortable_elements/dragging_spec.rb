require 'spec_helper'

describe '#drag jquery elements on sortable lists' do
  before do
    Capybara.app = Hey.new('sortable.html')
    @user = Kameleon::User::Guest.new(self)
  end
end
