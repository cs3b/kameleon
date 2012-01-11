require 'spec_helper'

describe '#see selected jquery elements' do
  before do
    Capybara.app = Hey.new('selectable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see by id' do
    @user.see :selected => '#item-4'
  end

  it 'should see by label' do
    @user.see :selected => 'Selected first item'
  end

  it 'should see many at once' do
    @user.see :selected => %w(#item-2 #item-4)
  end

  context 'when element is not selected' do
    it 'should raise error' do
      expect do
        @user.see :selected => '#item-1'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when element does not exist' do
    it 'should raise error' do
      expect do
        @user.see :selected => '#doesNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
