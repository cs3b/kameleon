require 'spec_helper'

describe 'dragged elements - target location is expressed in units' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see dragged by css' do
    @user.see :dragged => { '#draggable' => ['53px', '97px'] }
  end

  it 'should see dragged by xpath' do
    @user.see :dragged => { [:xpath, '//div[@id="secondDraggable"]'] => ['200px', '200px'] }
  end

  it 'should see dragged by text within' do
    @user.see :dragged => { 'Drag me around' => ['53px', '97px']}
  end

  context 'when was not dragged to target location' do
    it 'should raise error' do
      expect do
        @user.see :dragged => { '#draggable' => ['-30px', '30px'] }
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
