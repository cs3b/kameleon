require 'spec_helper'

describe '#not_see dragged elements - target location is a text inside target loaction' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see dragged by css' do
    @user.not_see :dragged => { '#thirdDraggable' => 'Do not drop here' }
  end

  it 'should not see dragged by xpath' do
    @user.not_see :dragged => { [:xpath, '//div[@id="secondDraggable"]'] => 'Do not drop here' }
  end

  it 'should not see dragged by text within' do
    @user.not_see :dragged => { 'Drag me around' => 'Do not drop here' }
  end

  context 'when was dragged to target location' do
    it 'should raise error' do
      expect do
        @user.not_see :dragged => { '#thirdDiv' => 'Drop here'}
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when target location does not exist' do
    it 'should raise error' do
      expect do
        @user.not_see :dragged => { '#draggable' => 'Does not exist' }
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
