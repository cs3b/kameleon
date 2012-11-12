require 'spec_helper'

describe "fill in" do
  before(:each) { visit('/form_elements') }
  context "single value in field" do
    context "text field" do
      it "text" do
        see :empty => ['sampleEmptyInput',
                       'textarea2']
        fill_in 'Value for sampleEmtyInput' => 'sampleEmptyInput',
                'Value for textarea2' => 'textarea2'
        see 'Value for textarea2' => 'textarea2',
            'Value for sampleEmtyInput' => 'sampleEmptyInput'
      end

      it "fixnum", :pending do
        see :empty => 'sampleEmptyInput'
        fill_in 12 => 'sampleEmptyInput'
        see '12' => 'sampleEmptyInput'
      end

      it "Float", :pending do
        see :empty => 'sampleEmptyInput'
        fill_in 12.45 => 'sampleEmptyInput'
        see '12.45' => 'sampleEmptyInput'
      end
    end


    it "checkbox" do
      see :unchecked => 'Sample unchecked checkbox'
      fill_in :check => 'Sample unchecked checkbox'
      see :checked => 'Sample unchecked checkbox'
      fill_in :uncheck => 'Sample checked checkbox'
      see :unchecked => 'Sample checked checkbox'
    end

    it "radio button" do
      see :unchecked => 'Option one is not checked'
      fill_in :choose => 'Option one is not checked'
      see :checked => 'Option one is not checked'
      fill_in :choose => 'Option two can is checked'
      see :unchecked => 'Option one is not checked',
          :checked => 'Option two can is checked'
    end

    it "select" do
      see :unselected => {2 => 'multiSelect'}
      fill_in :select => {2 => 'multiSelect'}
      see :selected => {2 => 'multiSelect'}
      fill_in :unselect => {2 => 'multiSelect'}
      see :unselected => {2 => 'multiSelect'}
    end

    # it have more sense in ruby 1.9.x and above
    #   e.g. select: { inactive: 'q_active_eq' }
    it "select values passed as symbols" do
      see :unselected => {:inactive => 'someSymbolSelect'}
      fill_in :select => {:inactive => 'someSymbolSelect'}
      see :selected => {:inactive => 'someSymbolSelect'}
    end

    it "attach file" do
      fill_in :attach => {'sample.txt' => 'Active File input'}
      click "Save Changes"
      pending
      #! we need to verify if file have been enclosed
    end
  end

  context "single value in many fields" do
    it "text" do
      text_fields = ['sampleEmptyInput',
                     'textarea2']
      see :empty => text_fields
      fill_in 'some common value' => text_fields
      see 'some common value' => text_fields
    end
    it "checkbox" do
      checkboxes = ['Sample unchecked checkbox',
                    'Option One Checkbox']
      see :unchecked => checkboxes
      fill_in :check => checkboxes
      see :checked => checkboxes
    end

    it "radio button" do
      radio_buttons = ['Option one is not checked',
                       'Option five is not checked']
      see :unchecked => radio_buttons
      fill_in :choose => radio_buttons
      see :checked => radio_buttons
    end
  end

  it "multiple values from one select" do
    select_options = {['2', '1'] => 'multiSelect'}
    see :unselected => select_options
    fill_in :select => select_options
    see :selected => select_options
  end

  it "multiple different fields at once" do
    fill_in 'Value for sampleEmtyInput' => 'sampleEmptyInput',
            :check => 'Sample unchecked checkbox',
            :select => {'2' => 'multiSelect'},
            :choose => ['Option one is not checked',
                        'Option five is not checked']

    see 'Value for sampleEmtyInput' => 'sampleEmptyInput',
        :checked => 'Sample unchecked checkbox',
        :selected => {'2' => 'multiSelect'},
        :checked => ['Option one is not checked',
                     'Option five is not checked']
  end
end




