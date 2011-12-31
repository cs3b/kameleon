require 'spec_helper'

describe 'see form elements - selects' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should verify status "selected" by id' do
    @user.see :selected => { '3' => 'normalSelect' }
  end

  it 'should verify status "selected" by label' do
    @user.see :selected => { '3' => 'Select' }
  end

  it 'should verify status "unselected" by id' do
    @user.see :unselected => { '2' => 'normalSelect' }
  end

  it 'should verify status "unselected" by label' do
    @user.see :unselected => { '4' => 'Select' }
  end

  context 'when verify many options at once' do
    it 'should verify status "unselected"' do
      @user.see :unselected => { '1' => 'Select', '2' => 'Select' }
    end

    context 'at least one has other status' do
      it 'should raise error' do
        expect do
          @user.see :selected => { '1' => 'Select', '3' => 'Select', '2' => 'Select' }
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
