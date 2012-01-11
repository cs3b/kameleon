require 'spec_helper'

describe '#not_see sortable elements' do
  before do
    Capybara.app = Hey.new('sortable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see by css selector' do
    @user.not_see :sortable => '#otherDiv'
  end

  it 'should not see by xpath' do
    @user.not_see :sortable => [:xpath, '//div[@id="otherDiv"]']
  end

  it 'should not see many at once' do
    @user.not_see :sortable => %w(#otherDiv #secondOtherDiv)
  end

  context 'when element is sortable' do
    it 'should raise error' do
      expect do
        @user.not_see :sortable => '#sortable'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when element does not exist' do
    it 'should raise error' do
      expect do
        @user.not_see :sortable => '#doesNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
