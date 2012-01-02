require 'spec_helper'

describe 'draging element' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should dragging by css' do
    @user.see :dragged => { '#draggable' => ['53px', '97px'] }
    @user.drag '#draggable' => ['100px', '50px']
    @user.see :dragged => { '#draggable' => ['100px', '50px'] }
  end

  it 'should dragging by xpath' do
    @user.see :dragged => { '#secondDraggable' => ['200px', '200px'] }
    @user.drag [:xpath, '//div[@id="secondDraggable"]'] => ['300px', '300px']
    @user.see :dragged => { [:xpath, '//div[@id="secondDraggable"]'] => ['300px', '300px'] }
  end

  it 'should dragging by text inside element' do
    @user.see :dragged => { '#draggable' => ['53px', '97px'] }
    @user.drag 'Drag me around' => ['100px', '50px']
    @user.see :dragged => { '#draggable' => ['100px', '50px'] }
  end

  it 'should dragging many elements at once' do
    @user.see :dragged => { '#draggable' => ['53px', '97px'],
                            '#secondDraggable' => ['200px', '200px'] }
    @user.drag '#draggable' => ['100px', '100px'],
               '#secondDraggable' => ['300px', '300px']
    @user.see :dragged => { '#draggable' => ['100px', '100px'],
                            '#secondDraggable' => ['300px', '300px'] }
  end

  context 'when is disabled' do
    it 'should not dragging to specific position' do
      @user.see :dragged => { '#disabledElement' => ['300px', '100px'] }
      @user.drag '#disabledElement' => ['-30px', '30px']
      @user.see :dragged => { '#disabledElement' => ['300px', '100px'] }
    end
  end

  context 'when does not exist' do
    it 'should raise error' do
      expect do
        @user.drag '#elemDoesNotExist' => ['-30px', '30px']
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
