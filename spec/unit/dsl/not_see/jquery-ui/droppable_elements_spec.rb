require 'spec_helper'

describe '#not_see droppable elements' do
  before do
    Capybara.app = Hey.new('droppable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see by css selector' do
    @user.not_see :droppable => '#draggable'
  end

  it 'should not see by xpath' do
    @user.not_see :droppable => [:xpath, '//div[@id="draggable"]']
  end

  it 'should not see many at once' do
    @user.not_see :droppable => %w(#draggable #otherDiv)
  end

  context 'when element is droppable' do
    it 'should raise error' do
      @user.not_see :droppable => '#droppable'
    end
  end

  context 'when element does not exist' do
    it 'should raise error' do
      expect do
        @user.not_see :droppable => '#doesNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
