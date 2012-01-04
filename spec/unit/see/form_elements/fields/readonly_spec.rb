require 'spec_helper'

describe 'see readonly fields' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context 'when text inside fields is not provied' do
    it 'should verify status for id' do
      @user.see :readonly => 'readonlyInput'
      @user.not_see :readonly => 'xlInput'
    end

    it 'should verify status for label' do
      @user.see :readonly => 'Readonly input'
      @user.not_see :readonly => 'X-Large input'
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

  context 'when text inside fields is provied' do
    it 'should verify status for id' do
      @user.see :readonly => { 'sample readonly value' => 'readonlyInput' }
      @user.not_see :readonly => { 'this is great value' => 'xlInput' }
    end

    it 'should verify status for label' do
      @user.see :readonly => { 'sample readonly value' => 'Readonly input' }
      @user.not_see :readonly => { 'this is great value' => 'X-Large input' }
    end

    it 'should verify many fields at once' do
      @user.see :readonly => { 'sample readonly value' => 'Readonly input',
                               'Readonly Textarea' => 'second readonly textarea' }
      @user.not_see :readonly => { 'this is great value' => 'X-Large input',
                                   'sample text in second textarea 2' => 'secondTextarea2' }
    end

    context 'when field does not exist' do
      it 'should raise error' do
        expect do
          @user.see :readonly => { 'Readonly input here carry on.' => 'DoesNotExist' }
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end

    context 'when field has other inside text' do
      it 'should raise error' do
        expect do
          @user.see :readonly => { 'Other text inside.' => 'Readonly input' }
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end

    context 'when at least one is not readonly' do
      it 'should raise error' do
        expect do
          @user.see :readonly => { 'sample readonly value' => 'Readonly input',
                                   'sample text in second textarea 2' => 'secondTextarea2' }
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
