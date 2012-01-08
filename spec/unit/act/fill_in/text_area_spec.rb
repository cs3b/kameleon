require 'spec_helper'

describe 'fill textarea' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should fill by id' do
    @user.will do
      see :empty => 'textarea2'
      fill_in 'Value for textarea2' => 'textarea2'
      see 'Value for textarea2' => 'textarea2'
    end
  end

  it 'should fill by label' do
    @user.will do
      see :empty => 'Textarea'
      fill_in 'Value for Textarea' => 'Textarea'
      see 'Value for Textarea' => 'Textarea'
    end
  end

  context 'when is disabled' do
    it 'should not fill' do
      @user.will do
        see :empty => 'Disabled textarea'
        fill_in 'Text should not be in this field' => 'Disabled textarea'
        see :empty => 'Disabled textarea'
      end
    end
  end

  context 'when is readonly' do
    it 'should not fill' do
      @user.will do
        see :empty => 'Readonly textarea'
        fill_in 'Text should not be in this field' => 'Readonly textarea'
        see :empty => 'Readonly textarea'
      end
    end
  end

  context 'when does not exist' do
    it 'should raise error' do
      expect do
        @user.fill_in 'Value for does not exist text area' => 'Bad text area'
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
