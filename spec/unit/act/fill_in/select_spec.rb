require 'spec_helper'

describe 'fill in select' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
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
    it 'should not select value' do
      @user.will do
        see :unselected => { 'second option' => 'Disabled select one option' }
        fill_in :select => { 'second option' => 'Disabled select one option' }
        see :unselected => { 'second option' => 'Disabled select one option' }
      end
    end
  end
end
