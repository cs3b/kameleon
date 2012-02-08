#encoding: utf-8
require 'spec_helper'

describe '#see special elements - ordered texts' do
  before do
    Capybara.app = Hey.new('special_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should see text in proper order' do
    @user.see :ordered => ['Michal Czyz', 'Tomasz Bak', 'Rafal Bromirski']
  end

  context 'when different order' do
    it 'should raise error' do
      expect do
        @user.see :ordered => ['Tomasz Bak', 'Michal Czyz', 'Rafal Bromirski']
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
