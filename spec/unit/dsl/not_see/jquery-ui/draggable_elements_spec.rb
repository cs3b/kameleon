require 'spec_helper'

describe '#not_see draggable elements' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see by css selector' do
    @user.not_see :draggable => '#otherDiv'
  end

  it 'should not see by xpath' do
    @user.not_see :draggable => [:xpath, '//div[@id="otherDiv"]']
  end

  it 'should not see many at once' do
    @user.not_see :draggable => %w(#otherDiv #dropHere)
  end

  context 'when element is draggable' do
    it 'should raise error' do
      expect do
        @user.not_see :draggable => '#draggable'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when element does not exist' do
    it 'should raise error' do
      expect do
        @user.not_see :draggable => '#doesNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
