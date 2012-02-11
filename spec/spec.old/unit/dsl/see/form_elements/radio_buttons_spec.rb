#encoding: utf-8
require 'spec_helper'

describe '#see form elements - radio buttons' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/form_elements.html')
  end

  context 'status "checked"' do
    it 'should verify checked status' do
      @user.see :checked => "Option one is this and that—be sure to include why it's great"
    end
  end

  context 'status "unchecked"' do
    it 'should verify unchecked status' do
      @user.see :unchecked => "Option two can is something else and selecting it will deselect options 1"
    end

    it 'should verify many radio buttons at once' do
      @user.see :unchecked => ["Option two can is something else and selecting it will deselect options 1",
                               "Option three can is something else and selecting it will deselect options 1"]
    end
  end

  context 'at least one has other status' do
    it 'should raise error' do
      expect do
        @user.see :checked => ["Option one is this and that—be sure to include why it's great",
                               "Option two can is something else and selecting it will deselect options 1"]
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
