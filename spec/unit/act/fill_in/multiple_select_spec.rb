require_relative 'fill_in_helper'

describe 'fill in multiple select' do
  it 'should select by id' do
    @user.will do
      see :unselected => { '2' => 'multiSelect' }
      fill_in :select => { '2' => 'multiSelect' }
      see :selected => { '2' => 'multiSelect' }
    end
  end

  it 'should select by label' do
    @user.will do
      see :unselected => { '1' => 'Multiple select' }
      fill_in :select => { '1' => 'Multiple select' }
      see :selected => { '1' => 'Multiple select' }
    end
  end

  it 'should select multiple values' do
    @user.will do
      see :unselected => { '1' => 'Multiple select', '2' => 'Multiple select' }
      fill_in :select => { '1' => 'Multiple select', '2' => 'Multiple select'  }
      see :selected => { '1' => 'Multiple select', '2' => 'Multiple select' }
    end
  end

  context 'when is disabled' do
    it 'should not select values' do
      @user.will do
        see :unselected => { 'first' => 'Disabled Multiple select' }
        fill_in :select => { 'first' => 'Disabled Multiple select' }
        see :unselected => { 'first' => 'Disabled Multiple select' }
      end
    end
  end
end
