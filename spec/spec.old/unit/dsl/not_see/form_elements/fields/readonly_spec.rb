require 'spec_helper'

describe '#not_see readonly fields' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/form_elements.html')
  end

  context 'when text inside fields is not provied' do
    it 'should verify status for id' do
      @user.not_see :readonly => 'xlInput'
    end

    it 'should verify status for label' do
      @user.not_see :readonly => 'X-Large input'
    end

    it 'should verify many fields at once' do
      @user.not_see :readonly => ['xlInput', 'X-Large input']
    end

    context 'when field does not exist' do
      it 'should raise error' do
        expect do
          @user.not_see :readonly => 'DoesNotExist'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end

    context 'when at least one is readonly' do
      it 'should raise error' do
        expect do
          @user.not_see :readonly => ['Readonly input', 'X-Large input']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
