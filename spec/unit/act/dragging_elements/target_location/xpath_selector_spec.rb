require 'spec_helper'

describe 'dragging element - target element is a xpath selector' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should dragging by css' do
    @user.see :dragged => { '#draggable' => ['53px', '97px'] }
    @user.drag '#draggable' => [:xpath, '//div[@id="dropHere"]']
    @user.see :dragged => { 'draggable' => '#dropHere' }
  end

  it 'should dragging by xpath' do
    @user.see :dragged => { '#draggable' => ['53px', '97px'] }
    @user.drag [:xpath, '//div[@id="secondDraggable"]'] => [:xpath, '//div[@id="dropHere"]']
    @user.see :dragged => { 'draggable' => '#dropHere' }
  end

  it 'should dragging by text inside element' do
    @user.see :dragged => { '#draggable' => ['53px', '97px'] }
    @user.drag 'Drag me around' => [:xpath, '//div[@id="dropHere"]']
    @user.see :dragged => { '#draggable' => '#dropHere' }
  end

  context 'when target location does not exist' do
    it 'should raise error' do
      expect do
        @user.drag '#draggable' => [:xpath, '//div[@id="doesNotExist"]']
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
