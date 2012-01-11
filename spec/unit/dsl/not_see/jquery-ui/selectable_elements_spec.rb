require 'spec_helper'

describe '#not_see selectable elements' do
  before do
    Capybara.app = Hey.new('selectable.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see by css selector' do
    @user.not_see :selectable => '#otherDiv'
  end

  it 'should not see by xpath' do
    @user.not_see :selectable => [:xpath, '//div[@id="otherDiv"]']
  end

  it 'should not see many at once' do
    @user.not_see :selectable => %w(#secondOtherDiv #otherDiv)
  end

  context 'when element is selectable' do
    it 'should raise error' do
      @user.not_see :selectable => '#selectable'
    end
  end

  context 'when element does not exist' do
    it 'should raise error' do
      expect do
        @user.not_see :selectable => '#doesNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
