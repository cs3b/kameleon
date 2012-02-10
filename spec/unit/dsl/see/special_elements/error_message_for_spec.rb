require 'spec_helper'

describe '#see special elements - error message for' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/error_message_for.html')
  end

  it 'should see one messages' do
    @user.see :error_message_for => 'name'
  end

  it 'should see many messages at once' do
    @user.see :error_messages_for => ['name', 'title', 'content']
  end

  context 'when at least one does not exist' do
    it 'should raise error' do
      expect do
        @user.see :error_messages_for => ['name', 'doesNotExist']
      end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
