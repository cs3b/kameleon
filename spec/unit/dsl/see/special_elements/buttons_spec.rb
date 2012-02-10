require 'spec_helper'

describe '#see special elements - buttons' do
  before do
    @user = Kameleon::User::Guest.new(self)
        @user.debug.visit('/special_elements.html')
  end

  it 'should see by id' do
    @user.see :button => 'superButton'
  end

  it 'should see by label' do
    @user.see :button => 'Super button'
  end

  it 'should see many buttons' do
    @user.see :button => ['Super button', 'Second super button']
  end

  context 'when does not exist' do
    it 'should raise error' do
      expect do
        @user.see :button => 'button does not exist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
