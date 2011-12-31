require 'spec_helper'

describe 'see form elements - textareas' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see by id' do
    @user.see 'sample text in textarea' => 'textarea3'
    @user.not_see 'another this is great value' => 'textarea3'
  end

  it 'should see by label' do
    @user.see 'sample text in textarea' => 'Textarea 3'
    @user.not_see 'another this is great value' => 'Textarea 3'
  end

  it 'should see many at once' do
    @user.see 'sample text in second textarea 2' => 'secondTextarea2',
              'sample text in textarea' => 'textarea3'

    @user.not_see 'other this is great value' => 'secondTextarea2',
                  'other sample default value' => 'textarea3'
  end

  context 'when it does not exist' do
    it 'should raise error' do
      expect do
        @user.see 'this is gread value' => 'textareaDoesNotExist'
      end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
