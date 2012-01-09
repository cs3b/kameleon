require 'spec_helper'

describe '#not_see special elements - links' do
  before do
    Capybara.app = Hey.new('special_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context 'when src is provided' do
    it 'should not see one link' do
      @user.not_see :link => { 'Maybe div' => '/i/do/not/know' }
    end

    it 'should not see many links' do
      @user.not_see :links => { 'Maybe div' => '/i/do/not/know',
                                'Maybe other div' => '/i/do/not/know/too' }
    end

    context 'when at least one exists' do
      it 'should raise error' do
        expect do
          @user.not_see :link => { 'What you want' => '/i-want/to',
                                   'Maybe div' => '/i/do/not/know' }
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  context 'when src path is not provided' do
    it 'should not see one link' do
      @user.not_see :link => 'Maybe div'
    end

    it 'should not see many links' do
      @user.not_see :links => ['Maybe div', 'Maybe other div']
    end

    context 'when at least one exists' do
      it 'should raise error' do
        expect do
          @user.not_see :link => ['What you want', 'Maybe div']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
