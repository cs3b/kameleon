#encoding: utf-8
require 'spec_helper'

describe '#not_see special selectors in tables' do
  before do
    Capybara.app = Hey.new('special_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context 'when in row' do
    it 'should not see text' do
      @user.within(:row => 'Michał Czyż') do
        not_see "17"
      end
    end
  end

  context 'when in column' do
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
