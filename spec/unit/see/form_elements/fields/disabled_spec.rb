require 'spec_helper'

describe 'see disabled fields' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should verify status for id' do
    @user.see :disabled => 'disabledInput'
  end

  it 'should verify status for label' do
    @user.see :disabled => 'Disabled input'
  end

  context 'when many disabled fields at once' do
    it 'should verify status' do
      @user.see :disabled => ['Disabled input', 'Disabled textarea']
    end

    context 'when at least one is enabled' do
      it 'should raise error' do
        expect do
          @user.see :disabled => ['Disabled input', 'Disabled textarea', 'X-Large input']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
