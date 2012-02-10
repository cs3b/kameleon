require 'spec_helper'

describe '#not_see texts' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/texts.html')
  end

  it 'should not see single text' do
    @user.not_see 'cool rails app'
  end

  it 'should not see many texts at once' do
    @user.not_see 'sinatra app', 'padrino app'
  end

  context 'when at least one text is visibile' do
    it 'should raise error' do
      expect do
        @user.not_see 'sinatra app', 'This is simple app'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
