require 'spec_helper'

describe '#see readonly fields' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/form_elements.html')
  end

  context 'when text inside fields is not provied' do
    it 'should verify status for id' do
      @user.see :readonly => 'readonlyInput'
    end

    it 'should verify status for label' do
      @user.see :readonly => 'Readonly input'
    end

    it 'should verify many fields at once' do
      @user.see :readonly => ['Readonly input', 'Readonly textarea']
    end

    context 'when field does not exist' do
      it 'should raise error' do
        expect do
          @user.see :readonly => 'DoesNotExist'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end

    context 'when at least one is not readonly' do
      it 'should raise error' do
        expect do
          @user.see :readonly => ['Readonly input', 'X-Large input']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
