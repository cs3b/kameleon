require 'spec_helper'

describe 'see special elements - images' do
  before do
    Capybara.app = Hey.new('special_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see by alt' do
    @user.see :image => "Logo_diamondmine"
  end

  it 'should see by src' do
    @user.see :image => "/images/logo_diamondmine.png?1324293836"
  end

  it 'should see many images' do
    @user.see :images => ['Logo_diamondmine', 'Logo_redmine']
  end

  context 'when does not exist' do
    it 'should raise error' do
      expect do
        @user.see :image => 'LinkDoesNotExist'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
