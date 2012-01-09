require 'spec_helper'

describe 'dragged elements - target location is a text inside target loaction' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see dragged by css' do
    @user.see :dragged => { '#thirdDraggable' => 'Drop Here' }
  end

  it 'should see dragged by xpath' do
    @user.see :dragged => { [:xpath, '//div[@id="secondDraggable"]'] => 'Drop Here' }
  end

  it 'should see dragged by text within' do
    @user.see :dragged => { 'Drag me around' => 'Drop Here' }
  end

  context 'when was not dragged to target location' do
    it 'should raise error' do
      expect do
        @user.see :dragged => { '#draggable' => 'Do not drop here'}
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when target location does not exist' do
    it 'should raise error' do
      expect do
        @user.see :dragged => { '#draggable' => 'Does not exist' }
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
