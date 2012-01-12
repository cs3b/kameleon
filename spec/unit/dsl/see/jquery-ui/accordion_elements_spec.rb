require 'spec_helper'

describe '#see accordion elements' do
  before do
    Capybara.app = Hey.new('accordion.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see by css selector' do
    @user.see :accordion => '#accordion'
  end

  it 'should see by xpath' do
    @user.see :accordion => [:xpath, '//div[@id="accordion"]']
  end

  it 'should see many at once' do
    @user.see :accordion => %w(#accordion #secondAccordion)
  end

  context 'when element is not accordion' do
    it 'should raise error' do
      expect do
        @user.see :accordion => '#otherDiv'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when element does not exist' do
    it 'should raise error' do
      expect do
        @user.see :accordion => '#doesNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
