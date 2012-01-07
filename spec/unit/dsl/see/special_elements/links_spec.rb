require 'spec_helper'

describe '#see special elements - links' do
  before do
    Capybara.app = Hey.new('special_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context 'when src is provided' do
    it 'should see one link' do
      @user.see :link => { 'What you want' => '/i-want/to' }
    end

    it 'should see many links' do
      @user.see :links => { 'What you want' => '/i-want/to',
                            'What I need' => '/what-i/need' }
    end

    context 'when link text does not exist' do
      it 'should raise error' do
        expect do
          @user.see :link => { 'What you want' => '/i-want/to',
                               'link does not exist' => '/what-i/need' }
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end

    context 'when src path does not exist' do
      it 'should raise error' do
        expect do
          @user.see :link => { 'What you want' => '/i-want/to',
                               'What I need' => 'src does not exist' }
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  context 'when src path is not provided' do
    it 'should see one link' do
      @user.see :link => 'What you want'
    end

    it 'should see many links' do
      @user.see :links => ['What you want', 'What I need']
    end

    context 'when at least one does not exist' do
      it 'should raise error' do
        expect do
          @user.see :link => ['What you want', 'does not exist']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
