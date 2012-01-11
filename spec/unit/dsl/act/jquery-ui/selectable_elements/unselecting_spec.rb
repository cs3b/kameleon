require 'spec_helper'

describe '#fill_in unselect jquery elements' do
  before do
    Capybara.app = Hey.new('selectable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should selecting by id' do
    @user.see :unselected => 'Unselected first item'
    @user.fill_in :select => 'Unselected first item'
    @user.see :selected => 'Unselected first item'
  end

  it 'should selecting by id' do
    @user.see :unselected => '#item-1'
    @user.fill_in :select => '#item-1'
    @user.see :selected => '#item-1'
  end

  it 'should selecting many elements at once' do
    @user.see :unselected => %w(item-1 item-3)
    @user.fill_in :select => %w(item-1 item-3)
    @user.see :selected => %w(item-1 item-3)
  end

  context 'when is disabled' do
    it 'should not selecting elements' do
      @user.see :unselected => %w(disabled-item-1 disabled-item-3)
      @user.fill_in :select => %w(disabled-item-1 disabled-item-3)
      @user.see :selected => %w(disabled-item-1 disabled-item-3)
    end
  end

  context 'when dragged element does not exist' do
    it 'should raise error' do
      expect do
        @user.fill_in :select => '#elemDoesNotExist'
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
