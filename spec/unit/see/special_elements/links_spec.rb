require 'spec_helper'

describe 'see special elements - links' do
  before do
    Capybara.app = Hey.new('special_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see one link' do
    @user.see :link => {'What you want' => '/i-want/to'}
  end

  it 'should see many links' do
    @user.see :links => {'What you want' => '/i-want/to',
                         'What I need' => '/what-i/need'}
  end

  context 'when does not exist' do
    it 'should raise error' do
      expect do
        @user.see :link => { 'link does not exist' => 'foo'}
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
