require 'spec_helper'

describe 'quantity' do
  before(:each) { visit('/elements_counter') }


  context "by selector" do
    it "using default type" do
      see 5 => '#fiveElements'
    end

    it "explicit defined" do
      see 5 => [:xpath, '//div[@id="fiveElements"]']
    end
  end

  it "by defined page areas" do
    Kameleon::Session.stub!(:defined_areas).and_return({
                                                           :menu_link => [:xpath, '//ul[@id="menu"]/li/a']
                                                       })
    see 7 => :menu_link
  end

  context "raise errors when" do
    it "there is less elements" do
       expect do
        see 6 => '#fiveElements'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it "there is more elements" do
      expect do
        see 4 => '#fiveElements'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  #! not sure if we need this
  #describe "ranges" do
  #
  #  it "elements within" do
  #    see 6..8 => '#fiveElements'
  #  end
  #
  #  it "exactly number of element (not more)" do
  #    see 5..5  => '#fiveElements'
  #  end
  #end
end
