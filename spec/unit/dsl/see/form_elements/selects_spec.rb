require 'spec_helper'

describe '#see form elements - selects' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/form_elements.html')
  end

  context 'status "selected"' do
    it 'should verify by id' do
      @user.see :selected => { '3' => 'normalSelect' }
    end

    it 'should verify by label' do
      @user.see :selected => { '3' => 'Select' }
    end
  end

  context 'status "unselected"' do
    it 'should verify by id' do
      @user.see :unselected => { '2' => 'normalSelect' }
    end

    it 'should verify by label' do
      @user.see :unselected => { '4' => 'Select' }
    end

    it 'should verify many options at once' do
      @user.see :unselected => { '1' => 'Select', '2' => 'Select' }
    end
  end

  context 'at least one has other status' do
    it 'should raise error' do
      expect do
        @user.see :selected => { '1' => 'Select', '3' => 'Select', '2' => 'Select' }
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
