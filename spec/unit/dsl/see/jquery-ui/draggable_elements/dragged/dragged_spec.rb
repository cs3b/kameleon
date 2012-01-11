require 'spec_helper'

describe 'dragged element' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see many dragged elements at once' do
    @user.see :dragged => { '#draggable' => ['53px', '97px'], '#secondDraggable' => ['200px', '200px'] }
  end

  context 'when dragged elemenent does not exist' do
    it 'should raise error' do
      expect do
        @user.see :dragged => { '#elemDoesNotExist' => ['-30px', '30px'] }
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
