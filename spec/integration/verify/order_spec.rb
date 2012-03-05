require 'spec_helper'

describe 'order', :focus => true do
  before(:each) { load_page('/special_elements') }

  it 'should see text in proper order' do
    see :ordered => ['Michal Czyz', 'Tomasz Bak', 'Rafal Bromirski']
  end

  context 'raise error' do
    it 'different order' do
      expect do
        see :ordered => ['Tomasz Bak', 'Michal Czyz', 'Rafal Bromirski']
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
    it 'not all elements present' do
      expect do
        see :ordered => ['Michal Czyz', 'Lukas Bak', 'Rafal Bromirski']
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end