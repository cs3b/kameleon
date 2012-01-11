require 'spec_helper'

describe '#see selectable elements' do
  before do
    Capybara.app = Hey.new('selectable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see by css selector' do
    @user.see :selectable => '#selectable'
  end

  it 'should see by xpath' do
    @user.see :selectable => [:xpath, '//div[@id="selectable"]']
  end

  it 'should see many at once' do
    @user.see :selectable => %w(#selectable #secondSelectable)
  end

  context 'when element is not selectable' do
    it 'should raise error' do
      expect do
        @user.see :selectable => '#otherDiv'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when element does not exist' do
    it 'should raise error' do
      expect do
        @user.see :selectable => '#doesNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
