require 'spec_helper'

describe '#see form elements - text inputs' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see by id' do
    @user.see 'this is great value' => 'xlInput'
  end

  it 'should see by label' do
    @user.see 'this is great value' => 'X-Large input'
  end

  it 'should see many at once' do
    @user.see 'this is great value' => 'xlInput',
              'sample default value' => 'secondInput'
  end

  context 'when it does not exist' do
    it 'should raise error' do
      expect do
        @user.see 'this is gread value' => 'fieldDoesNotExist'
      end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
