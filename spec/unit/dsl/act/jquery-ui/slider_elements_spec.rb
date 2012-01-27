require 'spec_helper'

describe '#drag slider elements' do
  before do
    Capybara.app = Hey.new('slider.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context 'when provided progress state is expressed in percents' do
    it 'should drag slider by id' do
      @user.see :slider => { 'firstSlider' => '50%' }
      @user.drag :slider => { 'firstSlider' => '30%' }
      @user.see :slider => { 'firstSlider' => '30%' }
    end

    it 'should drag many ot once' do
      @user.see :slider => { 'firstSlider' => '50%', 'secondSlider' => '50%' }
      @user.drag :slider => { 'firstSlider' => '30%', 'secondSlider' => '70%' }
      @user.see :slider => { 'firstSlider' => '30%', 'secondSlider' => '70%' }
    end

    context 'when progress state is higher than 100%' do
      it 'should drag slider to 100%' do
        @user.see :slider => { 'firstSlider' => '50%' }
        @user.drag :slider => { 'firstSlider' => '130%' }
        @user.see :slider => { 'firstSlider' => '100%' }
      end
    end

    context 'when progress state is lower than 0%' do
      it 'should drag slider to 0%' do
        @user.see :slider => { 'firstSlider' => '50%' }
        @user.drag :slider => { 'firstSlider' => '-10%' }
        @user.see :slider => { 'firstSlider' => '0%' }
      end
    end
  end

  context 'when provided progress state is expressed in number' do
    it 'should drag slider by id' do
      @user.see :slider => { 'firstSlider' => 20 }
      @user.drag :slider => { 'firstSlider' => 25 }
      @user.see :slider => { 'firstSlider' => 25 }
    end

    it 'should drag many sliders at once' do
      @user.see :slider => { 'firstSlider' => 20, 'secondSlider' => 50 }
      @user.drag :slider => { 'firstSlider' => 25, 'secondSlider' => 20 }
      @user.see :slider => { 'firstSlider' => 25, 'secondSlider' => 20 }
    end

    context 'when progress state is higher than max value' do
      it 'should drag slider to max value' do
        @user.see :slider => { 'firstSlider' => 20 }
        @user.drag :slider => { 'firstSlider' => 35 }
        @user.see :slider => { 'firstSlider' => 30 }
      end
    end

    context 'when progress state is lower than min value' do
      it 'should drag slider to min value' do
        @user.see :slider => { 'firstSlider' => 20 }
        @user.drag :slider => { 'firstSlider' => -10 }
        @user.see :slider => { 'firstSlider' => 0 }
      end
    end
  end

  context 'when slider element is disabled' do
    it 'should not drag slider' do
      @user.see :slider => { 'disabledSlider' => 30 }
      @user.drag :slider => { 'disabledSlider' => 50 }
      @user.see :slider => { 'disabledSlider' => 30 }
    end
  end

  context 'when slider element does not exist' do
    it 'should raise error' do
      expect do
        @user.drag :slider => { 'doesNotExist' => 10 }
      end.to raise_error(Capybara::ElementNotFound)
    end
  end

  context 'when element is not slider' do
    it 'should raise error' do
      expect do
        @user.drag :slider => { 'otherElement' => 20 }
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
