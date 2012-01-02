require 'spec_helper'

describe 'dragging element - target element is expressed in units' do
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
end
