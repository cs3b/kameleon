require 'spec_helper'

describe '#see unselected jquery elements' do
  before do
    Capybara.app = Hey.new('selectable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see by id' do
    @user.see :unselected => '#item-1'
  end

  it 'should see by label' do
    @user.see :unselected => 'Unselected first item'
  end

  it 'should see many at once' do
    @user.see :unselected => %w(#item-1 #item-3)
  end

  context 'when element is selected' do
    it 'should raise error' do
      expect do
        @user.see :unselected => '#item-2'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when element does not exist' do
    it 'should raise error' do
      expect do
        @user.see :unselected => '#doesNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
