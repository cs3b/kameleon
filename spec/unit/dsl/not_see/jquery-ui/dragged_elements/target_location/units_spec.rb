require 'spec_helper'

describe '#not_see dragged elements - target location is expressed in units' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see dragged by css' do
    @user.not_see :dragged => { '#draggable' => ['30px', '30px'] }
  end

  it 'should not see dragged by xpath' do
    @user.not_see :dragged => { [:xpath, '//div[@id="secondDraggable"]'] => ['20px', '20px'] }
  end

  it 'should not see dragged by text within' do
    @user.not_see :dragged => { 'Drag me around' => ['532px', '927px']}
  end

  context 'when was dragged to target location' do
    it 'should raise error' do
      expect do
        @user.not_see :dragged => { '#draggable' => ['53px', '97px'] }
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
