require 'spec_helper'

describe '#see droppable elements' do
  before do
    Capybara.app = Hey.new('droppable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see by css selector' do
    @user.see :droppable => '#droppable'
  end

  it 'should see by xpath' do
    @user.see :droppable => [:xpath, '//div[@id="droppable"]']
  end

  it 'should see many at once' do
    @user.see :droppable => %w(#droppable #secondDroppable)
  end

  context 'when element is not droppable' do
    it 'should raise error' do
      expect do
        @user.see :droppable => '#otherDiv'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when element does not exist' do
    it 'should raise error' do
      expect do
        @user.see :droppable => '#doesNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
