require 'spec_helper'

describe '#see slider elements' do
  before do
    Capybara.app = Hey.new('slider.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see one slider by id' do
    @user.see :slider => 'firstSlider'
  end

  it 'should see many sliders at once' do
    @user.see :sliders => %w(firstSlider secondSlider)
  end

  context 'when current progress state is provided in number' do
    it 'should see one slider' do
      @user.see :slider => { 'firstSlider' => 20 }
    end

    it 'should see many sliders bars at once' do
      @user.see :sliders => { 'firstSlider' => 20, 'secondSlider' => 50 }
    end

    context 'when provided progress state is wrong' do
      it 'should raise error' do
        expect do
          @user.see :slider => { 'firstSlider' => 50 }
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  context 'when current progress state is provided in percents' do
    it 'should see one slider' do
      @user.see :slider => { 'firstSlider' => '50%' }
    end

    it 'should see many sliders bars at once' do
      @user.see :sliders => { 'firstSlider' => '50%', 'secondSlider' => '50%' }
    end

    context 'when provided progress state is wrong' do
      it 'should raise error' do
        expect do
          @user.see :slider => { 'firstSlider' => '25%' }
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  context 'when element is not a slider' do
    it 'should raise error' do
      expect do
        @user.see :slider => 'otherElement'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when dialog does not exist' do
    it 'should raise error' do
      expect do
        @user.see :slider => 'doesNotExist'
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
