require 'spec_helper'

describe 'see readonly fields' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should verify status for id' do
    @user.see :readonly => 'readonlyInput'
    @user.not_see :readonly => 'xlInput'
  end

  it 'should verify status for label' do
    @user.see :readonly => 'Readonly input'
    @user.not_see :readonly => 'X-Large input'
  end

  context 'when many readonly fields at once' do
    it 'verify status' do
      @user.see :readonly => ['Readonly input', 'Readonly textarea']
    end

    context 'when at least one is not readonly' do
      it 'should raise error' do
        expect do
          @user.see :readonly => ['Readonly input', 'X-Large input']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
