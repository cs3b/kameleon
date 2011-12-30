#encoding: utf-8
require_relative 'fill_in_helper'

describe 'fill in radio button' do
  it 'should select by label' do
    @user.will do
      see :unchecked => "Option one is this and that—be sure to include why it's great"
      fill_in :check => "Option one is this and that—be sure to include why it's great"
      see :checked => "Option one is this and that—be sure to include why it's great"
    end
  end

  context 'when is disabled' do
    it 'should not select' do
      @user.will do
        see :unchecked => 'Option four - disabled'
        fill_in :check => 'Option four - disabled'
        see :unchecked => 'Option four - disabled'
      end
    end
  end

  context 'when does not exist' do
    it 'should raise error' do
      expect do
        @user.fill_in :check => 'This radio does not exist'
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
