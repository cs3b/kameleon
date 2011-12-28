require 'spec_helper'

describe 'see texts' do
  before do
    Capybara.app = Hey.new('texts.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context '#not_see' do
    it 'single param' do
      @user.not_see 'cool rails app'
    end

    it 'multiple params at once' do
      @user.not_see 'sinatra app', 'padrino app'
    end

    context 'at least one text is visibile' do
      it 'will fail' do
        expect do
          @user.not_see 'sinatra app', 'This is simple app'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  context '#see' do
    it 'single parameter' do
      @user.see 'This is simple app'
    end

    it 'multiple params at once' do
      @user.see 'This is simple app', 'and there is many lines', 'i that app'
    end

    context 'at least on text is not visible' do
      it 'will fail' do
        expect do
          @user.see 'sinatra app', 'and there is many lines'
        end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
