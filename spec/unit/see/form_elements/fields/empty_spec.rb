require 'spec_helper'

describe 'see empty fields' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should verify status for id' do
    @user.see :empty => 'prependedInput'
    @user.not_see :empty => 'xlInput'
  end

  it 'should verify status for label' do
    @user.see :empty => 'Prepended text'
    @user.not_see :empty => 'X-Large input'
  end

  context 'when many empty fields at once' do
    it 'should verify status' do
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
end
