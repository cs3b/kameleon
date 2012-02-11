#encoding: utf-8
require 'spec_helper'

describe '#not_see special selectors in tables' do

  context 'when in row' do
    before do
      @user = Kameleon::User::Guest.new(self)
      @user.debug.visit('/special_elements.html')
    end
    it 'should not see text' do
      @user.within(:row => 'Michal Czyz') do
        not_see "17"
      end
    end
  end

  context 'when in column' do
    before do
      @user = Kameleon::User::Guest.new(self, {:driver => :rack_test})
      @user.debug.visit('/special_elements.html')
    end
    context 'when scoped by full text' do
      it 'should not see text' do
        @user.within(:column => 'Selleo') do
          not_see "19.00", "17.00", "5.00"
        end
      end
    end

    context 'when scoped by partial text' do
      it 'should not see text' do
        @user.within(:column => 'lleo') do
          not_see "19.00", "17.00", "5.00"
        end
      end
    end
  end
end
