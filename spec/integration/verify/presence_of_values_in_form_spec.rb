require 'spec_helper'

describe "form inputs" do
  before(:each) { load_page('/form_elements') }

  describe "fields", :focus => true do
    it "field by label" do
      see :field => 'X-Large input'
    end

    it "multiple fields by once" do
      see :fields => ['X-Large input', 'xlInput']
    end

    context 'raise errors when' do
      it 'does not exist' do
        expect do
          see :field => 'doestNotExist'
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

    context "raise errors when", :focus => true do
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

end

#describe '#see form elements - checkboxes' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/form_elements.html')
#  end
#
#  context 'when status checked' do
#    it 'should verify by label' do
#      @user.see :checked => 'Option two can also be checked and included in form results'
#    end
#
#    it 'should verify by name' do
#      @user.see :checked => 'optionsCheckboxes_two'
#    end
#
#    it 'should verify many at once' do
#      @user.see :checked => ['Appended checkbox', 'appendedInput', 'optionsCheckboxes_two']
#    end
#  end
#
#  context 'when status unchecked' do
#    it 'should verify by label' do
#      @user.see :unchecked => "Option one is this and that—be sure to include why it's great"
#    end
#
#    it 'should verify by name' do
#      @user.see :unchecked => 'optionsCheckboxes_one'
#    end
#
#    it 'should verify many at once' do
#      @user.see :unchecked => ['Prepended checkbox', 'optionsCheckboxes', 'optionsCheckboxes_one']
#    end
#  end
#
#  context 'when at least one has other status than other checkboxes' do
#    it 'should raise error' do
#      expect do
#        @user.see :checked =>['Appended checkbox', 'appendedInput', 'optionsCheckboxes_one']
#      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end
#

#
#
#describe '#see form elements - multiple selects' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/form_elements.html')
#  end
#
#  context 'when status "selected"' do
#    it 'should verify by id' do
#      @user.see :selected => {'3' => 'normalSelect'}
#    end
#
#    it 'should verify by label' do
#      @user.see :selected => {'3' => 'Select one option'}
#    end
#
#    it 'should verify many at once' do
#      @user.see :selected => {'3' => 'Select one option',
#                              'second option' => 'Disabled select one option'}
#    end
#  end
#
#  context 'when status "unselected"' do
#    it 'should verify by id' do
#      @user.see :unselected => {'1' => 'Select one option'}
#    end
#
#    it 'should verify by label' do
#      @user.see :unselected => {'5' => 'normalSelect'}
#    end
#
#    it 'should verify many status at once' do
#      @user.see :unselected => {'5' => 'Select one option',
#                                '2' => 'Select one option'}
#    end
#  end
#
#  context 'at least one has other status' do
#    it 'should raise error' do
#      expect do
#        @user.see :selected => {'5' => 'Select one option',
#                                '3' => 'Select one option'}
#      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end
#
#describe '#see form elements - radio buttons' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/form_elements.html')
#  end
#
#  context 'status "checked"' do
#    it 'should verify checked status' do
#      @user.see :checked => "Option one is this and that—be sure to include why it's great"
#    end
#  end
#
#  context 'status "unchecked"' do
#    it 'should verify unchecked status' do
#      @user.see :unchecked => "Option two can is something else and selecting it will deselect options 1"
#    end
#
#    it 'should verify many radio buttons at once' do
#      @user.see :unchecked => ["Option two can is something else and selecting it will deselect options 1",
#                               "Option three can is something else and selecting it will deselect options 1"]
#    end
#  end
#
#  context 'at least one has other status' do
#    it 'should raise error' do
#      expect do
#        @user.see :checked => ["Option one is this and that—be sure to include why it's great",
#                               "Option two can is something else and selecting it will deselect options 1"]
#      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end
#
#
#describe '#see form elements - selects' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/form_elements.html')
#  end
#
#  context 'status "selected"' do
#    it 'should verify by id' do
#      @user.see :selected => { '3' => 'normalSelect' }
#    end
#
#    it 'should verify by label' do
#      @user.see :selected => { '3' => 'Select' }
#    end
#  end
#
#  context 'status "unselected"' do
#    it 'should verify by id' do
#      @user.see :unselected => { '2' => 'normalSelect' }
#    end
#
#    it 'should verify by label' do
#      @user.see :unselected => { '4' => 'Select' }
#    end
#
#    it 'should verify many options at once' do
#      @user.see :unselected => { '1' => 'Select', '2' => 'Select' }
#    end
#  end
#
#  context 'at least one has other status' do
#    it 'should raise error' do
#      expect do
#        @user.see :selected => { '1' => 'Select', '3' => 'Select', '2' => 'Select' }
#      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end
#
#

#
#

#
#
#describe '#see disabled fields' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/form_elements.html')
#  end
#
#  it 'should verify status for id' do
#    @user.see :disabled => 'disabledInput'
#  end
#
#  it 'should verify status for label' do
#    @user.see :disabled => 'Disabled input'
#  end
#
#  context 'when many disabled fields at once' do
#    it 'should verify status' do
#      @user.see :disabled => ['Disabled input', 'Disabled textarea']
#    end
#
#    context 'when at least one is enabled' do
#      it 'should raise error' do
#        expect do
#          @user.see :disabled => ['Disabled input', 'Disabled textarea', 'X-Large input']
#        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#      end
#    end
#  end
#end
#
#
#describe '#see empty fields' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/form_elements.html')
#  end
#
#  it 'should verify status for id' do
#    @user.see :empty => 'prependedInput'
#  end
#
#  it 'should verify status for label' do
#    @user.see :empty => 'Prepended text'
#  end
#
#  it 'should verify status for many fields' do
#    @user.see :empty => ['Prepended text', 'Textarea']
#  end
#
#  context 'when at least one is not empty' do
#    it 'should raise error' do
#      expect do
#        @user.see :empty => ['Prepended text', 'Sample Input']
#      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end
#
#
#describe '#see readonly fields' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/form_elements.html')
#  end
#
#  context 'when text inside fields is not provied' do
#    it 'should verify status for id' do
#      @user.see :readonly => 'readonlyInput'
#    end
#
#    it 'should verify status for label' do
#      @user.see :readonly => 'Readonly input'
#    end
#
#    it 'should verify many fields at once' do
#      @user.see :readonly => ['Readonly input', 'Readonly textarea']
#    end
#
#    context 'when field does not exist' do
#      it 'should raise error' do
#        expect do
#          @user.see :readonly => 'DoesNotExist'
#        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#      end
#    end
#
#    context 'when at least one is not readonly' do
#      it 'should raise error' do
#        expect do
#          @user.see :readonly => ['Readonly input', 'X-Large input']
#        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#      end
#    end
#  end
#end
