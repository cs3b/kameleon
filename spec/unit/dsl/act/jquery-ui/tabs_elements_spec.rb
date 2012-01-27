require 'spec_helper'

describe '#click on header section in tab elements' do
  before do
    Capybara.app = Hey.new('tab.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should switch to other tab by full header text' do
    @user.see 'Good text in first tab'
    @user.not_see 'Better text in second tab'
    @user.click 'Second tab'
    @user.see 'Better text in second tab'
    @user.not_see 'Good text in first tab'
  end

  it 'should switch to other tab by partial header text' do
    @user.see 'Good text in first tab'
    @user.not_see 'Better text in second tab'
    @user.click 'Second t'
    @user.see 'Better text in second tab'
    @user.not_see 'Good text in first tab'
  end

  it 'should switch to other tabs in many elements at once' do
    @user.see 'Good text in first tab', 'Good text is here'
    @user.not_see 'Better text in second tab', 'Better text is here'
    @user.click 'Second tab', 'Second position'
    @user.see 'Better text in second tab', 'Better text is here'
    @user.not_see 'Good text in first tab', 'Good text is here'
  end

  context 'when header text does not exist on page' do
    it 'should raise error' do
      expect do
        @user.click 'somethingElse'
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
