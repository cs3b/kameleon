require 'spec_helper'

describe '#fill_in autocomplete inputs' do
  before do
    Capybara.app = Hey.new('autocomplete.html')
    @user = Kameleon::User::Guest.new(self)
  end

  context 'when selected name is unambiguous' do
    it 'should automatically fill input with selected name by id' do
      @user.see :empty => 'tags'
      @user.fill_in 'JavaSc' => 'tags', :type => :autocomplete
      @user.see 'JavaScript' => 'tags'
    end

    it 'should automatically fill input with selected name by label' do
      @user.see :empty => 'tags'
      @user.fill_in 'JavaSc' => 'Tags:', :type => :autocomplete
      @user.see 'JavaScript' => 'tags'
    end
  end

  context 'when selected name is ambiguous' do
    it 'should not fill input with selected name by id' do
      @user.see :empty => 'tags'
      @user.fill_in 'Java' => 'tags', :type => :autocomplete
      @user.see :empty => 'tags'
    end

    it 'should not fill input with selected name by label' do
      @user.see :empty => 'tags'
      @user.fill_in 'Java' => 'Tags:', :type => :autocomplete
      @user.see :empty => 'tags'
    end
  end

  context 'when selected name does not exist in list' do
    it 'should not fill input with selected name by id' do
      @user.see :empty => 'tags'
      @user.fill_in 'Other' => 'tags', :type => :autocomplete
      @user.see :empty => 'tags'
    end

    it 'should not fill input with selected name by label' do
      @user.see :empty => 'tags'
      @user.fill_in 'Other' => 'Tags:', :type => :autocomplete
      @user.see :empty => 'tags'
    end
  end

  context 'when input is not autocomplete' do
    it 'should not fill input with selected name by id' do
      @user.see :empty => 'sampleOther'
      @user.fill_in 'Other' => 'sampleOther', :type => :autocomplete
      @user.see :empty => 'sampleOther'
    end

    it 'should not fill input with selected name by label' do
      @user.see :empty => 'sampleOther'
      @user.fill_in 'Other' => 'Other input:', :type => :autocomplete
      @user.see :empty => 'sampleOther'
    end
  end

  context 'when input does not exist' do
    it 'should raise error' do
      expect do
        @user.fill_in 'sample' => 'doesNotExist', :type => :autocomplete
      end.to raise_error(Capybara::ElementNotFound)
    end
  end

  context 'when input is disabled' do
    it 'should not fill input with selected name by id' do
      @user.see :empty => 'tagsInDisabledInput'
      @user.fill_in 'JavaSc' => 'tagsInDisabledInput', :type => :autocomplete
      @user.see :empty => 'tagsInDisabledInput'
    end

    it 'should not fill input with selected name by label' do
      @user.see :empty => 'tagsInDisabledInput'
      @user.fill_in 'JavaSc' => 'Tags in disabled input:', :type => :autocomplete
      @user.see :empty => 'tagsInDisabledInput'
    end
  end

  context 'when autocomplete is disabled' do
    it 'should not fill input with selected name by id' do
      @user.see :empty => 'disabledTags'
      @user.fill_in 'Other' => 'disabledTags', :type => :autocomplete
      @user.see :empty => 'disabledTags'
    end

    it 'should not fill input with selected name by label' do
      @user.see :empty => 'disabledTags'
      @user.fill_in 'Other' => 'Disabled tags:', :type => :autocomplete
      @user.see :empty => 'disabledTags'
    end
  end
end
