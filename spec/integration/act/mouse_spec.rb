require 'spec_helper'

#describe '#click' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/click.html')
#  end
#
#  it 'should clicks on links and buttons at once' do
#    @user.click 'Save changes', 'Load Next Page', 'Save changes'
#  end
#
#  context 'when buttons' do
#    it 'should click on button' do
#      @user.click 'Save changes'
#    end
#
#    it 'should click on cancel form' do
#      @user.click 'Cancel'
#    end
#
#    it 'should click with dismissing pop-up' do
#      @user.click :and_dismiss => 'Confirm button'
#    end
#
#    it 'should click with accepting pop-up' do
#      @user.click :and_accept => 'Confirm button'
#    end
#  end
#
#  context 'when links' do
#    it 'should click on link' do
#      @user.click 'Load Next Page'
#    end
#
#    it 'should click with dismissing pop-up' do
#      @user.click :and_dismiss => 'Confirm link'
#    end
#
#    it 'should click with accepting pop-up' do
#      @user.click :and_accept => 'Confirm link'
#    end
#  end
#
#  context 'when at least one does not exist' do
#    it 'should raise error' do
#      expect do
#        @user.click 'Save changes', 'Load Next Page', 'Submit', 'Load Next Page'
#      end.to raise_error(Capybara::ElementNotFound)
#    end
#  end
#end
