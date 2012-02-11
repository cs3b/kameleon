#encoding: utf-8
require 'spec_helper'

describe '#see form elements - checkboxes' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/form_elements.html')
  end

  context 'when status checked' do
    it 'should verify by label' do
      @user.see :checked => 'Option two can also be checked and included in form results'
    end

    it 'should verify by name' do
      @user.see :checked => 'optionsCheckboxes_two'
    end

    it 'should verify many at once' do
      @user.see :checked => ['Appended checkbox', 'appendedInput', 'optionsCheckboxes_two']
    end
  end

  context 'when status unchecked' do
    it 'should verify by label' do
      @user.see :unchecked => "Option one is this and that—be sure to include why it's great"
    end

    it 'should verify by name' do
      @user.see :unchecked => 'optionsCheckboxes_one'
    end

    it 'should verify many at once' do
      @user.see :unchecked => ['Prepended checkbox', 'optionsCheckboxes', 'optionsCheckboxes_one']
    end
  end

  context 'when at least one has other status than other checkboxes' do
    it 'should raise error' do
      expect do
        @user.see :checked =>['Appended checkbox', 'appendedInput', 'optionsCheckboxes_one']
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
