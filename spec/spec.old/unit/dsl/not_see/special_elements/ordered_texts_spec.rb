#encoding: utf-8
require 'spec_helper'

describe '#not_see special elements - ordered texts' do
  before do
    @user = Kameleon::User::Guest.new(self)
        @user.debug.visit('/special_elements.html')
  end

  it 'should not see text in proper order' do
    @user.not_see :ordered => ['Tomasz Bak', 'Michal Czyz', 'Rafal Bromirski']
  end

  context 'when texts is in proper order' do
    it 'should raise error' do
      expect do
        @user.not_see :ordered => ['Michal Czyz', 'Tomasz Bak', 'Rafal Bromirski']
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
