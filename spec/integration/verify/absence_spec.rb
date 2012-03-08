require 'spec_helper'

describe "absence of" do

  describe "texts" do
    before(:each) { visit('/texts') }

    it "can be tested by single or multiple arguments" do
      not_see 'cool rails app'
      not_see 'sinatra app', 'padrino app'
    end

    context "raise errors when" do
      it "text present" do
        expect do
          not_see 'This is simple app'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "one of texts is present" do
        expect do
          not_see 'this text is not present', 'This is simple app'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "links" do
    before(:each) { visit('/texts') }

    it "defined by text" do
      not_see :link => 'Maybe Div'
    end

    it "defined by text & url" do
      not_see :link => {'There is link with that text' => '/but/not/with/that/link'}
    end

    it "check multiple by once" do
      not_see :links => {'Maybe div' => '/i/do/not/know',
                          'Maybe other div' => '/i/do/not/know/too'}
    end

    context "raise errors when" do
      it "link with text present" do
        expect do
          not_see :link => 'What you want'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "at least one link together with src present" do
        expect do
          not_see :links => [{'What I need' => '/neighter/this'}, "No link with text", {'What you want' => '/i-want/to'}]
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "images", :status => :pending do
    before(:each) { visit('/special_elements') }

    it "single check" do
      not_see :image => 'sample_first'
    end
    it "multiple" do
      not_see :images => %w(sample_first sample_second)
    end

    context "raise errors when" do
      it "image is present" do
        expect do
          not_see :image => 'Logo_diamondmine'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "one of the image is present" do
        expect do
          not_see :images => %w(sample_first Logo_diamondmine)
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "fields" do
    before(:each) { visit('/form_elements') }

    it "one" do
      not_see :field => 'maybeDiv'
    end

    it "many" do
      not_see :fields => ['maybeDiv', 'Some Label']
    end

    context "raise errors when" do
      it "field present" do
        expect do
          not_see :field => 'xlInput'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "one of field present" do
        expect do
          not_see :fields => ['maybeDiv', 'X-Large input']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end


  #! not_see :ordered
  # the only value that it comes with this is when you want to check if all elements are present but they are
  # ordered different ... hmn
end
