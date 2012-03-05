require 'spec_helper'

describe "absence of" do

  describe "texts" do
    before(:each) { load_page('/texts') }

    it "can be tested by single or multiple arguments" do
      unseeing 'cool rails app'
      unseeing 'sinatra app', 'padrino app'
    end

    context "raise errors when" do
      it "text present" do
        expect do
          unseeing 'This is simple app'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "one of texts is present" do
        expect do
          unseeing 'this text is not present', 'This is simple app'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "links" do
    before(:each) { load_page('/texts') }

    it "defined by text" do
      unseeing :link => 'Maybe Div'
    end

    it "defined by text & url" do
      unseeing :link => {'There is link with that text' => '/but/not/with/that/link'}
    end

    it "check multiple by once" do
      unseeing :links => {'Maybe div' => '/i/do/not/know',
                          'Maybe other div' => '/i/do/not/know/too'}
    end

    context "raise errors when" do
      it "link with text present" do
        expect do
          unseeing :link => 'What you want'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "at least one link together with src present" do
        expect do
          unseeing :links => [{'What I need' => '/neighter/this'}, "No link with text", {'What you want' => '/i-want/to'}]
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "images", :status => :pending do
    before(:each) { load_page('/special_elements') }

    it "single check" do
      unseeing :image => 'sample_first'
    end
    it "multiple" do
      unseeing :images => %w(sample_first sample_second)
    end

    context "raise errors when" do
      it "image is present" do
        expect do
          unseeing :image => 'Logo_diamondmine'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "one of the image is present" do
        expect do
          unseeing :images => %w(sample_first Logo_diamondmine)
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "fields", :status => :pending, :focus => true do
    before(:each) { load_page('/form_elements') }

    it "one" do
      unseeing :field => 'maybeDiv'
    end

    it "many" do
      unseeing :fields => ['maybeDiv', 'Some Label']
    end

    context "raise errors when" do
      it "field present" do
        expect do
          unseeing :field => 'xlInput'
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "one of field present" do
        expect do
          unseeing :fields => ['maybeDiv', 'X-Large input']
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end


  #! unseeing :ordered
  # the only value that it comes with this is when you want to check if all elements are present but they are
  # ordered different ... hmn
end
