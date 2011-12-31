require 'spec_helper'

describe 'see texts' do
  before do
    Capybara.app = Hey.new('texts.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see single text' do
    @user.see 'This is simple app'
  end

  it 'should see many text at once' do
    @user.see 'This is simple app', 'and there is many lines', 'i that app'
  end

  it 'should not see single text' do
    @user.not_see 'cool rails app'
  end

  it 'should not see many texts at once' do
    @user.not_see 'sinatra app', 'padrino app'
  end

  context 'when should see and at least one text is not visible' do
    it 'should raise error' do
      expect do
        @user.see 'sinatra app', 'and there is many lines'
      end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when should not see and at least one text is visibile' do
    it 'should raise error' do
      expect do
        @user.not_see 'sinatra app', 'This is simple app'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
