require 'spec_helper'

describe '#click in section on accordion elements' do
  before do
    Capybara.app = Hey.new('accordion.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should click by label' do
    @user.see 'First section'
    @user.not_see 'Second section', 'Third secion'
    @user.click 'Secion 2'
    @user.see 'Second secion'
    @user.not_see 'First section', 'Third secion'
  end

  it 'should click on many at once' do
    @user.see 'First section', 'Element 1'
    @user.not_see 'Second section', 'Third section', 'Element 2', 'Element 3'
    @user.click 'Second element', 'Section 2'
    @user.see 'Second section', 'Element 2'
    @user.not_see 'First section', 'Element 1', 'Third section', 'Element 3'
  end

  context 'when is disabled' do
    it 'should not open disabled section' do
      @user.see 'Disabled first 1 section'
      @user.not_see 'Disabled second 2 section', 'Disabled third 3 section'
      @user.lick 'Disabled section second'
      @user.see 'Disabled first 1 section'
      @user.not_see 'Disabled second 2 section', 'Disabled third 3 section'
    end
  end
end
