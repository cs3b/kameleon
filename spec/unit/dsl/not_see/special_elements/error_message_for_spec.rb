require 'spec_helper'

describe '#not_see special elements - error message for' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/error_message_for.html')
  end

  it 'should not see one messages' do
    @user.not_see :error_message_for => 'first field'
  end

  it 'should not see many messages at once' do
    @user.not_see :error_messages_for => ['first field', 'second field']
  end

  context 'when at least one exist' do
    it 'should raise error' do
      expect do
        @user.not_see :error_messages_for => ['name', 'doesNotExist']
      end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
