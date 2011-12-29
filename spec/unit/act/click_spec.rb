require 'spec_helper'

describe 'action click' do
  before do
    Capybara.app = Hey.new('act/click.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'clicks on link' do
    @user.click 'Load Next Page'
  end

  it 'clicks on button' do
    @user.click 'Save changes'
  end

  context 'chain many clicks' do
    it '' do
      @user.click 'Save changes', 'Load Next Page', 'Save changes'
    end

    context 'at least one of them not found' do
      it 'will fail' do
        expect {
          @user.click 'Save changes', 'Load Next Page', 'Submit', 'Load Next Page'
        }.to raise_error(Capybara::ElementNotFound)
      end
    end
  end
end
