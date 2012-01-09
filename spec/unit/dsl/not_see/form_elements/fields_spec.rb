require 'spec_helper'

describe '#not_see form elements - fields' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see by label' do
    @user.not_see :field => 'maybeDiv'
  end

  it 'should not see many at once' do
    @user.not_see :fields => ['maybeDiv', 'maybeSecondDiv']
  end

  context 'when at least one exists' do
    it 'should raise error' do
      expect do
        @user.not_see :field => ['maybeDiv', 'multiSelect']
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
