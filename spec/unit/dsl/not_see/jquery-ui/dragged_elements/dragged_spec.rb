require 'spec_helper'

describe '#not_see dragged element' do
  before do
    Capybara.app = Hey.new('draggable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see many dragged elements at once' do
    @user.not_see :dragged => { '#draggable' => ['30px', '30px'], '#secondDraggable' => ['2px', '2px'] }
  end

  context 'when dragged elemenent exists' do
    it 'should raise error' do
      expect do
        @user.not_see :dragged => { '#draggable' => ['53px', '97px'] }
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
