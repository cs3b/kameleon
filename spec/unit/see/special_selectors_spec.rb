#encoding: utf-8
require 'spec_helper'

describe 'see special selectors in tables' do
  before do
    Capybara.app = Hey.new('special_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context 'when in row' do
    it 'should see full text' do
      @user.within(:row => 'Michał Czyż') do
        see "13.00"
        not_see "17.00"
      end
    end

    it 'should see partial text' do
      @user.within(:row => 'Michał Czyż') do
        see "13"
        not_see "17"
      end
    end
  end

  context 'when in column' do
    context 'when scoped by full text' do
      it 'should see full text' do
        @user.within(:column => 'Selleo') do
          see "13.00", "2.00", "0.00"
          not_see "19.00", "17.00", "5.00"
        end
      end

      it 'should see partial text' do
        @user.within(:column => 'Selleo') do
          see "13", "2", "0"
          not_see "19", "17", "5"
        end
      end
    end

    context 'when scoped by partial text' do
      it 'should see full text' do
        @user.within(:column => 'lleo') do
          see "13.00", "2.00", "0.00"
          not_see "19.00", "17.00", "5.00"
        end
      end

      it 'should see partial text' do
        @user.within(:column => 'lleo') do
          see "13", "2", "0"
          not_see "19", "17", "5"
        end
      end
    end
  end
end
