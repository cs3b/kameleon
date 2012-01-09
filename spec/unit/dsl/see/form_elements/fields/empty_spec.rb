require 'spec_helper'

describe '#see empty fields' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should verify status for id' do
    @user.see :empty => 'prependedInput'
  end

  it 'should verify status for label' do
    @user.see :empty => 'Prepended text'
  end

  it 'should verify status for many fields' do
    @user.see :empty => ['Prepended text', 'Textarea']
  end

  context 'when at least one is not empty' do
    it 'should raise error' do
      expect do
        @user.see :empty => ['Prepended text', 'Sample Input']
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
