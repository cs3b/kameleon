require 'spec_helper'

describe '#not_see form elements - text inputs' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/form_elements.html')
  end

  it 'should not see one' do
    @user.not_see 'sample other value' => 'maybeSimpleDiv'
  end

  it 'should not see many at once' do
    @user.not_see 'other this is great value' => 'maybeSimpleDiv',
                  'other sample default value' => 'maybeSimpleDiv'
  end

  context 'when exists' do
    it 'should raise error' do
      expect do
        @user.not_see 'sample default value' => 'secondInput',
                      'sample value' => 'maybeSimpleDiv'
      end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
