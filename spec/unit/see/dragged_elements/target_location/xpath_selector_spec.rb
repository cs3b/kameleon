require 'spec_helper'

describe 'dragged elements - target location is a xpath selector' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see dragged by css' do
    @user.see :dragged => { '#thirdDraggable' => [:xpath, '//div[@id="dropHere"]'] }
  end

  it 'should see dragged by xpath' do
    @user.see :dragged => { [:xpath, '//div[@id="secondDraggable"]'] => [:xpath, '//div[@id="dropHere"]'] }
  end

  it 'should see dragged by text within' do
    @user.see :dragged => { 'Drag me around' => [:xpath, '//div[@id="dropHere"]'] }
  end

  context 'when was not dragged to target location' do
    it 'should raise error' do
      expect do
        @user.see :dragged => { '#draggable' => [:xpath, '//div[@id="otherDiv"]'] }
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
