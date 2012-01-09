require 'spec_helper'

describe 'dragging element - target location is a droppable elelement' do
  before do
    Capybara.app = Hey.new('droppable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context 'when droppable element is enabled' do
    it 'should accept draged element'
  end

  context 'when droppable element is disabled' do
    it 'should not accept draged element'
  end
end
