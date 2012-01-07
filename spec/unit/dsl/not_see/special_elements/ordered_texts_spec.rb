#encoding: utf-8
require 'spec_helper'

describe '#not_see special elements - ordered texts' do
  before do
    Capybara.app = Hey.new('special_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should not see text in proper order' do
    @user.not_see :ordered => ['Tomasz Bąk', 'Michał Czyż', 'Rafał Bromirski']
  end

  context 'when texts is in proper order' do
    it 'should raise error' do
      expect do
        @user.not_see :ordered => ['Michał Czyż', 'Tomasz Bąk', 'Rafał Bromirski']
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
