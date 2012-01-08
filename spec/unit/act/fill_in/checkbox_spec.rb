#ecoding: utf-8
require 'spec_helper'

describe 'fill in checkbox' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should check by id' do
    @user.will do
      see :unchecked => 'first_unchecked_checkbox'
      fill_in :check => 'first_unchecked_checkbox'
      see :checked => 'first_unchecked_checkbox'
    end
  end

  it 'should check by label' do
    @user.will do
      see :unchecked => 'Sample unchecked checkbox'
      fill_in :check => 'Sample unchecked checkbox'
      see :checked => 'Sample unchecked checkbox'
    end
  end

  it 'should uncheck by id' do
    @user.will do
      see :checked => 'first_checked_checkbox'
      fill_in :uncheck => 'first_checked_checkbox'
      see :unchecked => 'first_checked_checkbox'
    end
  end

  it 'should uncheck by label' do
    @user.will do
      see :checked => 'Sample checked checkbox'
      fill_in :uncheck => 'Sample checked checkbox'
      see :unchecked => 'Sample checked checkbox'
    end
  end

  context 'when is disabled' do
    it 'should not do anything with disable checkbox' do
      @user.will do
        see :unchecked => 'Option four cannot be checked as it is disabled.'
        fill_in :check => 'Option four cannot be checked as it is disabled.'
        see :unchecked => 'Option four cannot be checked as it is disabled.'
      end
    end
  end

  context 'when does not exist' do
    it 'should raise error' do
      expect do
        @user.fill_in :check => 'Bad checkbox'
      end.should raise_error(Capybara::ElementNotFound)
    end
  end

  context 'many checkboxes' do
    it 'should check many checkboxes' do
      checkboxes = ['Sample unchecked checkbox', "Option one is this and that—be sure to include why it's great"]
      @user.will do
        see :unchecked => checkboxes
        fill_in :check => checkboxes
        see :checked => checkboxes
      end
    end

    it 'should uncheck many checkboxes' do
      checkboxes = ['Sample checked checkbox', 'Option two can also be checked and included in form results']
      @user.will do
        see :checked => checkboxes
        fill_in :uncheck => checkboxes
        see :unchecked => checkboxes
      end
    end

    context 'when at least chekbox does not exist' do
      it 'should raise error' do
        expect do
          @user.fill_in :check => ['Sample unchecked checkbox', 'Bad checkbox']
        end.to raise_error(Capybara::ElementNotFound)
      end
    end
  end
end
