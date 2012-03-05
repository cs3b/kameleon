require 'spec_helper'

describe "fill in", :status => :pending do
  before(:each) { load_page('/form_elements') }

  context "single value in field" do
    it "text" do
      fill_in "value" => 'Readonly input'
    end

    it "checkbox - check" do
       fill_in :check => 'Option Some'
    end

    it "checkbox - uncheck" do
      fill_in :uncheck => 'Option Checked'
    end

    it "radio button" do
      fill_in :check => 'Option four - disabled'
    end

    it "select" do
      fill_in :select => { 'first option' => 'Disabled select one option' }
    end

    it "attach file" do
      fill_in :attach => {'click.html' => 'Disable File input'}
    end
  end

  context "single value in many fields" do
    it "text"
    it "checkbox"
    it "radio button"
  end

  it "multiple values from one select" do

  end

  it "multiple fields at once" do

  end


end


#describe 'fill in checkbox' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/form_elements.html')
#  end
#
#  context 'when is disabled' do
#    it 'should not do anything with disable checkbox' do
#      @user.will do
#        see :unchecked => 'Option four cannot be checked as it is disabled.'
#        fill_in :check => 'Option four cannot be checked as it is disabled.'
#        see :unchecked => 'Option four cannot be checked as it is disabled.'
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
#  context 'when is disabled' do
#    it 'should not select values' do
#      @user.will do
#        see :unselected => { 'first' => 'Disabled Multiple select' }
#        fill_in :select => { 'first' => 'Disabled Multiple select' }
#        see :unselected => { 'first' => 'Disabled Multiple select' }
#      end
#    end
#  end
#end

##encoding: utf-8
#require 'spec_helper'
#
#describe 'fill in radio button' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/form_elements.html')
#  end
#
#  context 'when is disabled' do
#    it 'should not select' do
#      @user.will do
#        see :unchecked => 'Option four - disabled'
#
#        see :unchecked => 'Option four - disabled'
#      end
#    end
#  end
#
#end

#describe 'fill in select' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/form_elements.html')
#  end
#  context 'when is disabled' do
#    #! it should raise excpetions that you are not allowed to modify disabled field
#    it 'should not select value' do
#      @user.will do
#        see :unselected => { 'first option' => 'Disabled select one option' }
#        fill_in :select => { 'first option' => 'Disabled select one option' }
#        see :unselected => { 'first option' => 'Disabled select one option' }
#      end
#    end
#  end
#end

#describe 'fill textarea' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/form_elements.html')
#  end
#
#  context 'when is disabled' do
#    it 'should not fill' do
#      @user.will do
#        see :empty => 'Disabled textarea'
#        fill_in 'Text should not be in this field' => 'Disabled textarea'
#        see :empty => 'Disabled textarea'
#      end
#    end
#  end
#
#  context 'when is readonly' do
#    it 'should not fill' do
#      @user.will do
#        see :empty => 'Readonly textarea'
#        fill_in 'Text should not be in this field' => 'Readonly textarea'
#        see :empty => 'Readonly textarea'
#      end
#    end
#  end
#end

#describe 'fill text input' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/form_elements.html')
#  end
#
#  context 'when is disabled' do
#    it 'should not fill' do
#      @user.will do
#        see :empty => 'Disabled input'
#        fill_in 'Sample text' => 'Disabled input'
#        see :empty => 'Disabled input'
#      end
#    end
#  end
#
#  context 'when is readonly' do
#    it 'should not fill' do
#      @user.will do
#        see :empty => 'Readonly input'
#        fill_in 'Sample text' => 'Readonly input'
#        see :empty => 'Readonly input'
#      end
#    end
#  end
#end




