require 'spec_helper'

describe 'dragging element' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should dragging many elements at once' do
    @user.see :dragged => { '#draggable' => ['53px', '97px'],
                            '#secondDraggable' => ['200px', '200px'] }
    @user.drag '#draggable' => '#dropHere',
               '#secondDraggable' => '#dropHere'
    @user.see :dragged => { '#draggable' => '#dropHere',
                            '#secondDraggable' => '#dropHere' }
  end

  context 'when is disabled' do
    it 'should not dragging to specific position' do
      @user.see :dragged => { '#disabledElement' => ['300px', '100px'] }
      @user.drag '#disabledElement' => ['-30px', '30px']
      @user.see :dragged => { '#disabledElement' => ['300px', '100px'] }
    end
  end

  context 'when dragged element does not exist' do
    it 'should raise error' do
      expect do
        @user.drag '#elemDoesNotExist' => ['-30px', '30px']
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
