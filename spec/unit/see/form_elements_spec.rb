# encoding: utf-8
require 'spec_helper'

describe 'see form elements' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'notice "Error messages for"'

  context 'inputs' do
    it 'by id' do
      @user.see 'this is great value' => 'xlInput'
      @user.not_see 'another this is great value' => 'xlInput'
    end

    it 'by value' do
      @user.see 'this is great value' => 'X-Large input'
      @user.not_see 'another this is great value' => 'X-Large input'
    end

    it 'verify multiple inputs' do
      @user.see 'this is great value' => 'xlInput',
                'sample default value' => 'secondInput'

      @user.not_see 'other this is great value' => 'xlInput',
                    'other sample default value' => 'secondInput'
    end
  end

  context 'checkboxes' do
    context 'verify status "checked" for single checkbox by' do
      it 'by label' do
        @user.see :checked => 'Option two can also be checked and included in form results'
        @user.not_see :checked => "Option one is this and that—be sure to include why it's great"
      end

      it 'by name' do
        @user.see :checked => 'optionsCheckboxes_two'
        @user.not_see :checked => 'optionsCheckboxes_one'
      end
    end

    context 'verify status "unchecked" for single checkbox by' do
      it 'by label' do
        @user.see :unchecked => "Option one is this and that—be sure to include why it's great"
        @user.not_see :unchecked => 'Option two can also be checked and included in form results'
      end

      it 'by name' do
        @user.see :unchecked => 'optionsCheckboxes_one'
        @user.not_see :unchecked => 'optionsCheckboxes_two'
      end
    end

    context "verify status for multiple checkboxes" do
      it "checked" do
        @user.see :checked => ['Appended checkbox', 'appendedInput', 'optionsCheckboxes_two']
        @user.not_see :checked => ['optionsCheckboxes_one', 'optionsCheckboxes_three']
      end

      it "unchecked" do
        @user.see :unchecked => ["Prepended checkbox", "optionsCheckboxes", "optionsCheckboxes_one"]
        @user.not_see :unchecked => ['Appended checkbox', 'appendedInput', 'optionsCheckboxes_two']
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
    context 'verify status for single radio button' do
      it 'checked' do
        @user.see :checked => "Option one is this and that—be sure to include why it's great"
        @user.not_see :checked => "Option two can is something else and selecting it will deselect options 1"
      end

      it 'unchecked' do
        @user.see :unchecked => "Option two can is something else and selecting it will deselect options 1"
        @user.not_see :unchecked => "Option one is this and that—be sure to include why it's great"
      end
    end

    context "verify status for multiple radio buttons" do
      it 'unchcked' do
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

  context 'fields' do
    context 'disabled' do
      it 'by id' do
        @user.see :disabled => 'disabledInput'
        @user.not_see :disabled => 'xlInput'
      end

      it 'by label' do
        @user.see :disabled => 'Disabled input'
        @user.not_see :disabled => 'X-Large input'
      end

      context 'multiple disabled fields' do
        it 'verify status' do
          @user.see :disabled => ['Disabled input', 'Disabled textarea']
        end

        context 'at least one is enabled' do
          it 'will fail' do
            expect do
              @user.see :disabled => ['Disabled input', 'Disabled textarea', 'X-Large input']
            end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
          end
        end
      end
    end

    context 'readonly' do
      it 'by id' do
        @user.see :readonly => 'readonlyInput'
        @user.not_see :readonly => 'xlInput'
      end

      it 'by label' do
        @user.see :readonly => 'Readonly input'
        @user.not_see :readonly => 'X-Large input'
      end

      context 'multiple readonly fields' do
        it 'verify status' do
          @user.see :readonly => ['Readonly input', 'Readonly textarea']
        end

        context 'at least one is not readonly' do
          it 'will fail' do
            expect do
              @user.see :readonly => ['Readonly input', 'X-Large input']
            end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
          end
        end
      end
    end

    context 'empty' do
      it 'by id' do
        @user.see :empty => 'prependedInput'
        @user.not_see :empty => 'xlInput'
      end

      it 'by label' do
        @user.see :empty => 'Prepended text'
        @user.not_see :empty => 'X-Large input'
      end

      context 'multiple empty fields' do
        it 'verify status' do
          @user.see :empty => ['Prepended text', 'Textarea']
        end

        context 'at least one is not empty' do
          it 'will fail' do
            expect do
              @user.see :empty => ['Prepended text', 'Sample Input']
            end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
          end
        end
      end
    end
  end
end
