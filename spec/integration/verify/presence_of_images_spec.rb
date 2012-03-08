require 'spec_helper'

describe "presence of image" do
  before(:each) { visit('/special_elements') }

  it "by alt attribute" do
    see :image => "Logo_diamondmine"
  end

  it "by src attribute" do
    see :image => "/images/logo_diamondmine.png?1324293836"
  end

  it "many at once" do
    see :images => ['Logo_diamondmine', 'Logo_redmine', "/images/logo_diamondmine.png?1324293836"]
  end

  context "raise errors when" do
    it "haven't found image with alt" do
      expect do
        see :image => 'NoImageWithThatAlt'
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it "haven't found image with src" do
      expect do
        see :images => ['Logo_redmine', "/images/logo_selleo_com.png"]
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end