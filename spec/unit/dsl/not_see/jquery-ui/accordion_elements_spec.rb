require 'spec_helper'

describe '#not_see accordion elements' do
  before do
    Capybara.app = Hey.new('accordion.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see by css selector' do
    @user.not_see :accordion => '#otherDiv'
  end

  it 'should not see by xpath' do
    @user.not_see :accordion => [:xpath, '//div[@id="otherDiv"]']
  end

  it 'should not see many at once' do
    @user.not_see :accordion => %w(#otherDiv #secondOtherDiv)
  end

  context 'when element is accordion' do
    it 'should raise error' do
      expect do
        @user.not_see :accordion => '#accordion'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when element does not exist' do
    it 'should raise error' do
      expect do
        @user.not_see :accordion => '#doesNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
