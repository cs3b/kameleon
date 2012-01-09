require 'spec_helper'

describe '#not_see empty fields' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should verify status for id' do
    @user.not_see :empty => 'xlInput'
  end

  it 'should verify status for label' do
    @user.not_see :empty => 'X-Large input'
  end

  context 'when many empty fields at once' do
    it 'should verify status' do
      @user.not_see :empty => ['xlInput', 'X-Large input']
    end

    context 'when at least one is not empty' do
      it 'should raise error' do
        expect do
          @user.not_see :empty => ['Prepended text', 'Sample Input']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end

    context 'when at least one does not exist' do
      it 'should raise error' do
        expect do
          @user.not_see :empty => ['Prepended text', 'Sample Input']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
