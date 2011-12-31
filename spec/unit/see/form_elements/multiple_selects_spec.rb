require 'spec_helper'

describe 'see form elements - multiple selects' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should verify status "selected" by id' do
    @user.see :selected => { 'first selected' => 'defaultSelectedOptions' }
  end

  it 'should verify status "selected" by label' do
    @user.see :selected => { 'second selected' => 'Here are the default selections' }
  end

  it 'should verify status "unselected" by id' do
    @user.see :unselected => { 'first unselected' => 'defaultSelectedOptions' }
  end

  it 'should verify status "unselected" by label' do
    @user.see :unselected => { 'second unselected' => 'Here are the default selections' }
  end

  context 'when verify many options at once' do
    it 'should verify status "selected"' do
      @user.see :selected => { 'first selected' => 'defaultSelectedOptions',
                               'second selected' => 'defaultSelectedOptions' }
    end

    it 'should verify status "unselected"' do
      @user.see :unselected => { 'first unselected' => 'defaultSelectedOptions',
                                 'second unselected' => 'defaultSelectedOptions' }
    end

    context 'at least one has other status' do
      it 'should raise error' do
        expect do
          @user.see :selected => { 'first selected' => 'defaultSelectedOptions',
                                   'first unselected' => 'defaultSelectedOptions' }
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
