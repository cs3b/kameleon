require 'spec_helper'

describe '#see sortable elements' do
  before do
    Capybara.app = Hey.new('sortable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see by css selector' do
    @user.see :sortable => '#sortable'
  end

  it 'should see by xpath' do
    @user.see :sortable => [:xpath, '//div[@id="sortable"]']
  end

  it 'should see many at once' do
    @user.see :sortable => %w(#sortable #secondSortable)
  end

  context 'when element is not sortable' do
    it 'should raise error' do
      expect do
        @user.see :sortable => '#otherDiv'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when element does not exist' do
    it 'should raise error' do
      expect do
        @user.see :sortable => '#doesNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
