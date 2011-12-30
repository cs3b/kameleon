require_relative 'fill_in_helper'

describe 'fill text input' do
  it 'should fill by id' do
    @user.will do
      see :empty => 'sampleEmptyInput'
      fill_in 'Value for sampleEmtyInput' => 'sampleEmptyInput'
      see 'Value for sampleEmtyInput' => 'sampleEmptyInput'
    end
  end

  it 'should fill by label' do
    @user.will do
      see :empty => 'Sample empty input'
      fill_in 'Value for Sample empty input' => 'Sample empty input'
      see 'Value for Sample empty input' => 'Sample empty input'
    end
  end

  context 'when is disabled' do
    it 'should not fill' do
      @user.will do
        see :empty => 'Disabled input'
        fill_in 'Sample text' => 'Disabled input'
        see :empty => 'Disabled input'
      end
    end
  end

  context 'when is readonly' do
    it 'should not fill' do
      @user.will do
        see :empty => 'Readonly input'
        fill_in 'Sample text' => 'Readonly input'
        see :empty => 'Readonly input'
      end
    end
  end

  context 'when does not exist' do
    it 'should raise error' do
      expect do
        @user.fill_in 'Value for does not exist field' => 'Bad field'
      end.to raise_error(Capybara::ElementNotFound)
    end
  end
end
