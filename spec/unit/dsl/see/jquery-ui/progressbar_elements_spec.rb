require 'spec_helper'

describe '#see progress bar elements' do
  before do
    Capybara.app = Hey.new('progress_bar.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see one progress bar by id' do
    @user.see :progress_bar => 'firstProgressBar'
  end

  it 'should see many progress bars at once' do
    @user.see :progress_bars => %w(firstProgressBar secondProgressBar)
  end

  context 'when current progress state is provided' do
    it 'should see one progress bar' do
      @user.see :progress_bar => { 'firstProgressBar' => 37 }
    end

    it 'should see many progress bars at once' do
      @user.see :progress_bars => { 'firstProgressBar' => 37, 'secondProgressBar' => 50 }
    end

    context 'when provided progress state is wrong' do
      it 'should raise error' do
        expect do
          @user.see :progress_bar => { 'firstProgressBar' => 50 }
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  context 'when element is not a progress bar' do
    it 'should raise error' do
      expect do
        @user.see :progress_bar => 'somethingElse'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when dialog does not exist' do
    it 'should raise error' do
      expect do
        @user.see :progressbar => 'doesNotExist'
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
