require 'spec_helper'

describe "fill in" do
  before(:each) { load_page('/form_elements') }
  context "single value in field" do
    it "text" do
      see :empty => ['sampleEmptyInput',
                     'textarea2']
      fill_in 'Value for sampleEmtyInput' => 'sampleEmptyInput',
              'Value for textarea2' => 'textarea2'
      see 'Value for textarea2' => 'textarea2',
          'Value for sampleEmtyInput' => 'sampleEmptyInput'
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
      see :unselected => {'2' => 'multiSelect'}
      fill_in :select => {'2' => 'multiSelect'}
      see :selected => {'2' => 'multiSelect'}
      fill_in :unselect => {'2' => 'multiSelect'}
      see :unselected => {'2' => 'multiSelect'}
    end

    it "attach file", :focus => true do
      fill_in :attach => {'click.html' => 'Disable File input'}
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
    pending
  end
end


#describe 'fill in attach file' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/form_elements.html')
#  end
#
#  it 'should attach file' do
#    @user.will do
#      see :empty => 'File input'
#      fill_in :attach => { 'click.html' => 'Active File input' }
#      see Kameleon::Utils::Helpers.default_path_for_file('click.html') => 'File input'
#    end
#  end
#
#  context 'when file does not exist' do
#    it 'should raise error' do
#      expect do
#        @user.will do
#          fill_in :attach => { 'path' => 'Active File input' }
#        end
#      end.to_not raise_error(RuntimeError, %w{Sorry but we didn't found that file in: path'})
#    end
#  end
#end




