require 'spec_helper'

describe '#not_see dragged elements - target location is a css selector' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see dragged by css' do
    @user.not_see :dragged => { '#thirdDraggable' => '#otherDiv' }
  end

  it 'should see dragged by xpath' do
    @user.not_see :dragged => { [:xpath, '//div[@id="secondDraggable"]'] => '#otherDiv' }
  end

  it 'should see dragged by text within' do
    @user.not_see :dragged => { 'Drag me around' => '#otherDiv' }
  end

  context 'when was dragged to target location' do
    it 'should raise error' do
      expect do
        @user.not_see :dragged => { '#thirdDiv' => '#otherDiv' }
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
