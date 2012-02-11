require 'spec_helper'

describe '#see texts' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/texts.html')
  end

  it 'should see single text' do
    @user.see 'This is simple app'
  end

  it 'should see many text at once' do
    @user.see 'This is simple app', 'and there is many lines', 'i that app'
  end

  context 'when at least one text is not visible' do
    it 'should raise error' do
      expect do
        @user.see 'sinatra app', 'and there is many lines'
      end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
