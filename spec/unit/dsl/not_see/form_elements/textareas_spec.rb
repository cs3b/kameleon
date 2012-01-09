require 'spec_helper'

describe '#not_see form elements - textareas' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see one' do
    @user.not_see 'another this is great value' => 'textarea3'
  end

  it 'should not see many at once' do
    @user.not_see 'other this is great value' => 'secondTextarea2',
                  'other sample default value' => 'textarea3'
  end

  context 'when exists' do
    it 'should raise error' do
      expect do
        @user.not_see 'sample text in second textarea 2' => 'secondTextarea2'
      end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
