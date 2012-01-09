require 'spec_helper'

describe 'dragged elements - target location is a css selector' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see dragged by css' do
    @user.see :dragged => { '#thirdDraggable' => '#dropHere' }
  end

  it 'should see dragged by xpath' do
    @user.see :dragged => { [:xpath, '//div[@id="secondDraggable"]'] => '#dropHere' }
  end

  it 'should see dragged by text within' do
    @user.see :dragged => { 'Drag me around' => '#dropHere' }
  end

  context 'when was not dragged to target location' do
    it 'should raise error' do
      expect do
        @user.see :dragged => { '#draggable' => '#otherDiv' }
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
