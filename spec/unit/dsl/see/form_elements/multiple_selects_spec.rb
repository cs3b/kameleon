require 'spec_helper'

describe '#see form elements - multiple selects' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context 'when status "selected"' do
    it 'should verify by id' do
      @user.see :selected => {'3' => 'normalSelect'}
    end

    it 'should verify by label' do
      @user.see :selected => {'3' => 'Select one option'}
    end

    it 'should verify many at once' do
      @user.see :selected => {'3' => 'Select one option',
                              'second option' => 'Disabled select one option'}
    end
  end

  context 'when status "unselected"' do
    it 'should verify by id' do
      @user.see :unselected => {'1' => 'Select one option'}
    end

    it 'should verify by label' do
      @user.see :unselected => {'5' => 'normalSelect'}
    end

    it 'should verify many status at once' do
      @user.see :unselected => {'5' => 'Select one option',
                                '2' => 'Select one option'}
    end
  end

  context 'at least one has other status' do
    it 'should raise error' do
      expect do
        @user.see :selected => {'5' => 'Select one option',
                                '3' => 'Select one option'}
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
