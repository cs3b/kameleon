# encoding: utf-8
require 'spec_helper'

# see values in forms (and can find them by id and by label)
#   including that can see empty field
describe 'see values in forms for' do
  before do
    Capybara.app = Hey.new('forms.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context 'inputs by' do
    it 'id' do
      @user.see 'this is great value' => 'xlInput'
    end

    it 'value' do
      @user.see 'this is great value' => 'X-Large input'
    end
  end

  context 'checkboxes' do
    context 'verify status "checked" for single checkbox by' do
      it 'id' do
        @user.see :checked => "appendedInput"
      end

      it 'label' do
        @user.see :checked => "Appended checkbox"
      end
    end

    context 'verify status "unchecked" for single checkboxby by' do
      it 'id' do
        @user.see :unchecked => "Prepended checkbox"
      end

      it 'label' do
        @user.see :unchecked => "prependedInput"
      end
    end

    context "verify status for multiple checkboxes when" do
      it "checked" do
        @user.see :checked => ["Appended checkbox", "appendedInput", "optionsCheckboxes_two"]
      end

      it "unchecked" do
        @user.see :unchecked => ["Prepended checkbox", "optionsCheckboxes", "optionsCheckboxes_one"]
      end

      context 'at least one has other status than other checkboxes' do
        it 'will fail' do
          expect do
            @user.see :checked => ["Appended checkbox", "appendedInput", "optionsCheckboxes_one"]
          end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
        end
      end
    end
  end

  context 'radio buttons' do
    context 'verify status "checked" for single radio button by' do
      it 'label' do
        @user.see :checked => "Option one is this and that—be sure to include why it's great"
      end
    end

    context 'verify status "unchecked" for single radio button by' do
      it 'label' do
        @user.see :unchecked => "Option two can is something else and selecting it will deselect options 1"
      end
    end

    context "verify status for multiple radio buttons" do
      it "unchecked" do
        @user.see :unchecked => ["Option two can is something else and selecting it will deselect options 1",
                                 "Option three can is something else and selecting it will deselect options 1"]
      end

      context 'at least one has other status than other checkboxes' do
        it 'will fail' do
          expect do
            @user.see :checked => ["Option one is this and that—be sure to include why it's great",
                                   "Option two can is something else and selecting it will deselect options 1"]
          end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
        end
      end
    end
  end

  context 'submit button by' do
    it 'id'
    it 'label'
  end

  context 'fields' do
    context 'disabled' do
      it 'id'
      it 'label'
    end

    context 'readonly' do
      it 'id'
      it 'label'
    end

    context 'empty' do
      it 'id'
      it 'label'
    end
  end

  context 'notice "Error messages for"'

  pending do
    context "see empty fields should validate many at once" do
      it "and fails when at least one input are not empty" do
        lambda {
          @user.see :empty => ["xlInput_two", "X-Large input"]
        }.should raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "succeed when all fields are empty" do
        @user.see :empty => ["xlInput_two", "xlInput_three"]
      end
    end
  end
end
