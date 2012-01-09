require 'spec_helper'

describe '#not_see special elements - images' do
  before do
    Capybara.app = Hey.new('special_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see one image' do
    @user.not_see :image => 'sample_first'
  end

  it 'should not see many images' do
    @user.not_see :images => ['sample_first', 'sample_second']
  end

  context 'when at least one exists' do
    it 'should raise error' do
      expect do
        @user.not_see :image => ['sample_first', 'Logo_diamondmine']
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
