require 'spec_helper'

describe '#drag jquery elements on sortable lists' do
  before do
    Capybara.app = Hey.new('sortable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context 'when target location is other element' do
    context 'when dragging element before other element' do
      it 'should dragging before element specific by label' do
        @user.see :ordered => ['Item 1', 'Item 2', 'Item 3', 'Item 4']
        @user.drag 'Item 1', :before => 'Item 3'
        @user.see :ordered => ['Item 2', 'Item 1', 'Item 3', 'Item 4']
      end

      it 'should dragging before element specific by id' do
        @user.see :ordered => ['Item 1', 'Item 2', 'Item 3', 'Item 4']
        @user.drag 'item-1', :before => 'item-3'
        @user.see :ordered => ['Item 2', 'Item 1', 'Item 3', 'Item 4']
      end
    end

    context 'when dragging element after other element' do
      it 'should dragging after element specific by label' do
        @user.see :ordered => ['Item 1', 'Item 2', 'Item 3', 'Item 4']
        @user.drag 'Item 1', :after => 'Item 2'
        @user.see :ordered => ['Item 2', 'Item 1', 'Item 3', 'Item 4']
      end

      it 'should dragging after element specific by id' do
        @user.see :ordered => ['Item 1', 'Item 2', 'Item 3', 'Item 4']
        @user.drag 'item-1', :after => 'item-2'
        @user.see :ordered => ['Item 2', 'Item 1', 'Item 3', 'Item 4']
      end
    end

    context 'when target element does not exist' do
      it 'should raise error' do
        expect do
          @user.drag 'item-1', :after => 'doesnotExist'
        end.to raise_error(Capybara::ElementNotFound)
      end
    end
  end

  context 'when target location is position on list' do
    it 'should dragging element to begin of list' do
      @user.see :ordered => ['Item 1', 'Item 2', 'Item 3', 'Item 4']
      @user.drag 'item-3', :to => :begin
      @user.see :ordered => ['Item 3', 'Item 1', 'Item 2', 'Item 4']
    end

    it 'should dragging element to end of list' do
      @user.see :ordered => ['Item 1', 'Item 2', 'Item 3', 'Item 4']
      @user.drag 'item-3', :to => :end
      @user.see :ordered => ['Item 3', 'Item 1', 'Item 4', 'Item 3']
    end
  end

  context 'when sortable list is disabled' do
    it 'should not dragging element on sortable list' do
      @user.see :ordered => ['Disabled item 1', 'Disabled item 2', 'Disabled item 3', 'Disabled item 4']
      @user.drag 'Disabled item 1', :to => :end
      @user.see :ordered => ['Disabled item 1', 'Disabled item 2', 'Disabled item 3', 'Disabled item 4']
    end
  end
end
