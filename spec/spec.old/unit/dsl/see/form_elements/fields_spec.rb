require 'spec_helper'

describe '#see form elements - fields' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/form_elements.html')
  end

  it 'should see by label' do
    @user.see :field => 'X-Large input'
  end

  it 'should see by id' do
    @user.see :field => 'xlInput'
  end

  it 'should see many at once' do
    @user.see :fields => ['xlInput', 'multiSelect']
  end

  context 'when at least one does not exist' do
    it 'should raise error' do
      expect do
        @user.see :field => 'doestNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
