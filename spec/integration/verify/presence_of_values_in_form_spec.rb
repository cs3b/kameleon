require 'spec_helper'

describe "form inputs" do
  before(:each) { load_page('/form_elements') }

  describe "fields" do
    it "field by label" do
      see :field => 'X-Large input'
    end

    it "multiple fields by once" do
      see :fields => ['X-Large input', 'xlInput']
    end

    context 'raise errors when' do
      it 'not exist' do
        expect do
          see :field => 'doestNotExist'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "empty" do
    it "single" do
      see :empty => 'prependedInput'
    end

    it "multiple" do
      see :empty => ['Prepended text',
                     'Textarea']
    end

    context "raise errors when" do
      it "when at least one field is not empty" do
        expect do
          see :empty => ['Prepended text', 'Sample Input']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "readonly" do
    it "single" do
      pending
      see :readonly => 'readonlyInput'
    end

    it "multiple" do
      pending
      see :readonly => ['Readonly input',
                        'Readonly textarea']
    end

    context "raise errors when" do
      it "when at least one field is editable" do
        pending
        expect do
          see :readonly => ['Readonly input', 'X-Large input']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "disabled" do
    it "single" do
      pending
      see :disabled => 'disabledInput'
    end

    it "multiple" do
      pending
      see :disabled => ['Disabled input',
                        'Disabled textarea']
    end

    context "raise errors when" do
      it "when at least one field is not disabled" do
        pending
        expect do
          see :disabled => ['Disabled input',
                            'Disabled textarea',
                            'X-Large input']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "text fields" do
    it "textinput" do
      see 'this is great value' => 'xlInput'
      see 'this is great value' => 'X-Large input'
    end

    it "textarea" do
      see 'sample text in textarea' => 'textarea3'
      see 'sample text in textarea' => 'Textarea 3'
    end

    context "raise errors when" do
      it "field not present" do
        expect do
          see 'this is great value' => 'textareaDoesNotExist'
        end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "one of the field have different value" do
        expect do
          see 'this is great value' => 'xlInput', 'one other non existent text' => 'Textarea 3'
        end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "checkboxes" do
    it "checked" do
      see :checked => 'Option two can also be checked and included in form results'
    end

    it "unchecked" do
      see :unchecked => "Sample unchecked checkbox"
    end

    it "multiple at once" do
      see :checked => ['Option two can also be checked and included in form results',
                       'Option two can also be checked and included in form results'],
          :unchecked => ["Sample unchecked checkbox",
                         "Option four cannot be checked as it is disabled."]
    end

    context "raise errors when" do
      it "non checked" do
        expect do
          see :checked => "Sample unchecked checkbox"
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "checked" do
        expect do
          see :unchecked => 'Option two can also be checked and included in form results'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "radio buttons" do
    it "checked" do
      see :checked => 'Another option which is checked'
    end

    it "unchecked" do
      see :unchecked => "Option three not checked"
    end

    it "multiple at once" do
      see :checked => ['Another option which is checked',
                       'Option four - disabled'],
          :unchecked => ["Option three not checked",
                         "Option one is not checked"]
    end

    context "raise errors when" do
      it "non checked" do
        expect do
          see :checked => "Option three not checked"
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "checked" do
        expect do
          see :unchecked => ["Option three not checked",
                             'Option four - disabled']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "select" do
    it "selected" do
      see :selected => {'3' => 'normalSelect'}
    end

    it "unselected" do
      see :unselected => {'1' => 'Select one option'}
    end

    it "multiple value within on select" do
      see :selected => {['3',
                         '6'] => 'Select many options'}
    end

    it "multiple selects at once" do
      see :selected => {'3' => 'Select one option',
                        'second option' => 'Disabled select one option'},
          :unselected => {'1' => 'Select one option'}
    end

    context "raise errors when" do
      it "when is selected" do
        expect do
          see :unselected => {'3' => 'normalSelect'}
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "when one is unselected" do
        expect do
          see :selected => {'5' => 'Select one option',
                            '3' => 'Select one option'}
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
