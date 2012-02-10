#encoding: utf-8
require 'spec_helper'

describe '#see special selectors in tables' do

  context 'when in row' do
    before do
      @user = Kameleon::User::Guest.new(self)
      @user.debug.visit('/special_elements.html')
    end
    it 'should see full text' do
      @user.within(:row => 'Michal Czyz') do
        see "13.00"
      end
    end

    it 'should see partial text' do
      @user.within(:row => 'Michal Czyz') do
        see "13"
      end
    end
  end

  context 'when in column' do
    before do
      @user = Kameleon::User::Guest.new(self, :driver => :rack_test)
      @user.debug.visit('/special_elements.html')
    end
    context 'when scoped by full text' do
      it 'should see full text' do
        @user.within(:column => 'Selleo') do
          see "13.00", "2.00", "0.00"
        end
      end

      it 'should see partial text' do
        @user.within(:column => 'Selleo') do
          see "13", "2", "0"
        end
      end
    end

    context 'when scoped by partial text' do
      it 'should see full text' do
        @user.within(:column => 'lleo') do
          see "13.00", "2.00", "0.00"
        end
      end

      it 'should see partial text' do
        @user.within(:column => 'lleo') do
          see "13", "2", "0"
        end
      end
    end
  end
end
