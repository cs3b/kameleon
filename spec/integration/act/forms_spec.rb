require 'spec_helper'

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

#describe 'fill in checkbox' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/form_elements.html')
#  end
#
#  it 'should check by id' do
#    @user.will do
#      see :unchecked => 'first_unchecked_checkbox'
#      fill_in :check => 'first_unchecked_checkbox'
#      see :checked => 'first_unchecked_checkbox'
#    end
#  end
#
#  it 'should check by label' do
#    @user.will do
#      see :unchecked => 'Sample unchecked checkbox'
#      fill_in :check => 'Sample unchecked checkbox'
#      see :checked => 'Sample unchecked checkbox'
#    end
#  end
#
#  it 'should uncheck by id' do
#    @user.will do
#      see :checked => 'first_checked_checkbox'
#      fill_in :uncheck => 'first_checked_checkbox'
#      see :unchecked => 'first_checked_checkbox'
#    end
#  end
#
#  it 'should uncheck by label' do
#    @user.will do
#      see :checked => 'Sample checked checkbox'
#      fill_in :uncheck => 'Sample checked checkbox'
#      see :unchecked => 'Sample checked checkbox'
#    end
#  end
#
#  context 'when does not exist' do
#    it 'should raise error' do
#      expect do
#        @user.fill_in :check => 'Bad checkbox'
#      end.should raise_error(Capybara::ElementNotFound)
#    end
#  end
#
#  context 'many checkboxes' do
#    it 'should check many checkboxes' do
#      checkboxes = ['Sample unchecked checkbox', "Option one is this and that—be sure to include why it's great"]
#      @user.will do
#        see :unchecked => checkboxes
#        fill_in :check => checkboxes
#        see :checked => checkboxes
#      end
#    end
#
#    it 'should uncheck many checkboxes' do
#      checkboxes = ['Sample checked checkbox', 'Option two can also be checked and included in form results']
#      @user.will do
#        see :checked => checkboxes
#        fill_in :uncheck => checkboxes
#        see :unchecked => checkboxes
#      end
#    end
#
#    context 'when at least one chekbox does not exist' do
#      it 'should raise error' do
#        expect do
#          @user.fill_in :check => ['Sample unchecked checkbox', 'Bad checkbox']
#        end.to raise_error(Capybara::ElementNotFound)
#      end
#    end
#  end
#end

#describe 'fill in multiple select' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/form_elements.html')
#  end
#
#  it 'should select by id' do
#    @user.will do
#      see :unselected => { '2' => 'multiSelect' }
#      fill_in :select => { '2' => 'multiSelect' }
#      see :selected => { '2' => 'multiSelect' }
#    end
#  end
#
#  it 'should select by label' do
#    @user.will do
#      see :unselected => { '1' => 'Multiple select' }
#      fill_in :select => { '1' => 'Multiple select' }
#      see :selected => { '1' => 'Multiple select' }
#    end
#  end
#
#  it 'should select multiple values' do
#    @user.will do
#      see :unselected => { '1' => 'Multiple select', '2' => 'Multiple select' }
#      fill_in :select => { '1' => 'Multiple select', '2' => 'Multiple select'  }
#      see :selected => { '1' => 'Multiple select', '2' => 'Multiple select' }
#    end
#  end
#
#end

#describe 'fill in radio button' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/form_elements.html')
#  end
#
#  it 'should select by label' do
#    @user.will do
#      see :unchecked => "Option one is this and that—be sure to include why it's great"
#      fill_in :check => "Option one is this and that—be sure to include why it's great"
#      see :checked => "Option one is this and that—be sure to include why it's great"
#    end
#  end
#
#  context 'when does not exist' do
#    it 'should raise error' do
#      expect do
#        @user.fill_in :check => 'This radio does not exist'
#      end.to raise_error(Capybara::ElementNotFound)
#    end
#  end
#end


#describe 'fill in select' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/form_elements.html')
#  end
#
#  it 'should select by id' do
#    @user.will do
#      see :unselected => { '2' => 'normalSelect' }
#      fill_in :select => { '2' => 'normalSelect' }
#      see :selected => { '2' => 'normalSelect' }
#    end
#  end
#
#  it 'should select by label' do
#    @user.will do
#      see :unselected => { '1' => 'Select one option' }
#      fill_in :select => { '1' => 'Select one option' }
#      see :selected => { '1' => 'Select one option' }
#    end
#  end
#end


#describe 'fill textarea' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/form_elements.html')
#  end
#
#  it 'should fill by id' do
#    @user.will do
#      see :empty => 'textarea2'
#      fill_in 'Value for textarea2' => 'textarea2'
#      see 'Value for textarea2' => 'textarea2'
#    end
#  end
#
#  it 'should fill by label' do
#    @user.will do
#      see :empty => 'Textarea'
#      fill_in 'Value for Textarea' => 'Textarea'
#      see 'Value for Textarea' => 'Textarea'
#    end
#  end
#
#  context 'when does not exist' do
#    it 'should raise error' do
#      expect do
#        @user.fill_in 'Value for does not exist text area' => 'Bad text area'
#      end.to raise_error(Capybara::ElementNotFound)
#    end
#  end
#end

#describe 'fill text input' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/form_elements.html')
#  end
#
#  it 'should fill by id' do
#    @user.will do
#      see :empty => 'sampleEmptyInput'
#      fill_in 'Value for sampleEmtyInput' => 'sampleEmptyInput'
#      see 'Value for sampleEmtyInput' => 'sampleEmptyInput'
#    end
#  end
#
#  it 'should fill by label' do
#    @user.will do
#      see :empty => 'Sample empty input'
#      fill_in 'Value for Sample empty input' => 'Sample empty input'
#      see 'Value for Sample empty input' => 'Sample empty input'
#    end
#  end
#
#  context 'when does not exist' do
#    it 'should raise error' do
#      expect do
#        @user.fill_in 'Value for does not exist field' => 'Bad field'
#      end.to raise_error(Capybara::ElementNotFound)
#    end
#  end
#end


