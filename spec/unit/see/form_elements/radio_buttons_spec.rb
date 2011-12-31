#encoding: utf-8
require 'spec_helper'

describe 'see form elements - radio buttons' do
  before do
    Capybara.app = Hey.new('form_elements.html')
    @user = Kameleon::User::Guest.new(self)
  end

  it 'should verify checked status' do
    @user.see :checked => "Option one is this and that—be sure to include why it's great"
    @user.not_see :checked => "Option two can is something else and selecting it will deselect options 1"
  end

  it 'should verify unchecked status' do
    @user.see :unchecked => "Option two can is something else and selecting it will deselect options 1"
    @user.not_see :unchecked => "Option one is this and that—be sure to include why it's great"
  end

  context "when verify many radio buttons at once" do
    it 'should verify unchcked status' do
      @user.see :unchecked => ["Option two can is something else and selecting it will deselect options 1",
                               "Option three can is something else and selecting it will deselect options 1"]
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
end
