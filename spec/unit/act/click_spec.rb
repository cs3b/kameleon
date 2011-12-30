require 'spec_helper'

describe '#click' do
  before do
    Capybara.app = Hey.new('click.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should click on link' do
    @user.click 'Load Next Page'
  end

  it 'should click on button' do
    @user.click 'Save changes'
  end

  context 'chain many clicks' do
    it 'should clicks on links and buttons' do
      @user.click 'Save changes', 'Load Next Page', 'Save changes'
    end

    context 'at least one of them not found' do
      it 'should fail' do
        expect {
          @user.click 'Save changes', 'Load Next Page', 'Submit', 'Load Next Page'
        }.to raise_error(Capybara::ElementNotFound)
      end
    end
  end
end
