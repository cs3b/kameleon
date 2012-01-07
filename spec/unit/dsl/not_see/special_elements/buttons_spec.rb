require 'spec_helper'

describe '#not_see special elements - buttons' do
  before do
    Capybara.app = Hey.new('special_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see one button' do
    @user.not_see :button => 'first'
  end

  it 'should not see many buttons' do
    @user.not_see :button => ['first button', 'second button']
  end

  context 'when exists' do
    it 'should raise error' do
      expect do
        @user.not_see :button => 'Super button'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
