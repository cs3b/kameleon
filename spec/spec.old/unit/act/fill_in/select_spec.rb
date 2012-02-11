require 'spec_helper'

describe 'fill in select' do
  before do
    @user = Kameleon::User::Guest.new(self)
        @user.debug.visit('/form_elements.html')
  end

  it 'should select by id' do
    @user.will do
      see :unselected => { '2' => 'normalSelect' }
      fill_in :select => { '2' => 'normalSelect' }
      see :selected => { '2' => 'normalSelect' }
    end
  end

  it 'should select by label' do
    @user.will do
      see :unselected => { '1' => 'Select one option' }
      fill_in :select => { '1' => 'Select one option' }
      see :selected => { '1' => 'Select one option' }
    end
  end

  context 'when is disabled' do
    #! it should raise excpetions that you are not allowed to modify disabled field
    it 'should not select value' do
      @user.will do
        see :unselected => { 'first option' => 'Disabled select one option' }
        fill_in :select => { 'first option' => 'Disabled select one option' }
        see :unselected => { 'first option' => 'Disabled select one option' }
      end
    end
  end
end
