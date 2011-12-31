#encoding: utf-8
require 'spec_helper'

describe 'see form elements - checkboxes' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should verify checked status by label' do
    @user.see :checked => 'Option two can also be checked and included in form results'
    @user.not_see :checked => "Option one is this and that—be sure to include why it's great"
  end

  it 'should verify checked status by name' do
    @user.see :checked => 'optionsCheckboxes_two'
    @user.not_see :checked => 'optionsCheckboxes_one'
  end

  it 'should verify unchecked status by label' do
    @user.see :unchecked => "Option one is this and that—be sure to include why it's great"
    @user.not_see :unchecked => 'Option two can also be checked and included in form results'
  end

  it 'should verify unchecked status by name' do
    @user.see :unchecked => 'optionsCheckboxes_one'
    @user.not_see :unchecked => 'optionsCheckboxes_two'
  end

  context 'when verify many checkboxes at once' do
    it 'should verify status checked' do
      @user.see :checked => ['Appended checkbox', 'appendedInput', 'optionsCheckboxes_two']
      @user.not_see :checked => ['optionsCheckboxes_one', 'optionsCheckboxes_three']
    end

    it 'should verify status unchecked' do
      @user.see :unchecked => ['Prepended checkbox', 'optionsCheckboxes', 'optionsCheckboxes_one']
      @user.not_see :unchecked => ['Appended checkbox', 'appendedInput', 'optionsCheckboxes_two']
    end

    context 'when at least one has other status than other checkboxes' do
      it 'should raise error' do
        expect do
          @user.see :checked =>['Appended checkbox', 'appendedInput', 'optionsCheckboxes_one']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
