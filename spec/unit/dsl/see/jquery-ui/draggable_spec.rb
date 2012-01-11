require 'spec_helper'

describe '#see draggable elements' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see by css selector' do
    @user.see :draggable => '#draggable'
  end

  it 'should see by xpath' do
    @user.see :draggable => [:xpath, '//div[@id="secondDraggable"]']
  end

  it 'should see many at once' do
    @user.see :draggable => %w(#draggable #secondDraggable)
  end

  context 'when element is not draggable' do
    it 'should raise error' do
      expect do
        @user.see :draggable => '#otherDiv'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when element does not exist' do
    it 'should raise error' do
      expect do
        @user.see :draggable => '#doesNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
