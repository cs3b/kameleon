require 'spec_helper'

#describe '#see special elements - ordered texts' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#        @user.debug.visit('/special_elements.html')
#  end
#
#  it 'should see text in proper order' do
#    @user.see :ordered => ['Michal Czyz', 'Tomasz Bak', 'Rafal Bromirski']
#  end
#
#  context 'when different order' do
#    it 'should raise error' do
#      expect do
#        @user.see :ordered => ['Tomasz Bak', 'Michal Czyz', 'Rafal Bromirski']
#      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#    end
#  end
#end