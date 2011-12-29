require 'spec_helper'

describe 'see counted elements' do
  before do
    Capybara.app = Hey.new('elements_counter.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context 'menu' do
    before do
      @user.stub!(:page_areas).and_return(:menu_link => [:xpath, '//ul[@id="menu"]/li/a'])
    end

    it 'see counted links' do
      @user.see 7 => :menu_link
    end
  end
end
