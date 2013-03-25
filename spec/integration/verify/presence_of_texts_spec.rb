require 'spec_helper'

describe "presence of" do
  describe "texts" do
    before(:each) { visit('/texts.html') }

    it "check single text" do
      see 'This is simple app'
    end

    it "many at once" do
      see 'and there is many lines',
          'in that app'
    end

    context "raise errors when" do
      it "text is not found" do
        expect do
          see 'This is simple app', 'and this line is not present'
        end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "objects with to_s method" do
    before(:each) do
      visit('/special_elements.html')
      @existing_user_1   = DummyUser.new('Michal', 'Czyz')
      @existing_user_2   = DummyUser.new('Michal', 'Czyz')
      @non_existing_user = DummyUser.new('Alfred', 'Boom')
    end

    it "check single object" do
      see @existing_user_1
    end

    it "many at once" do
      see @existing_user_1,
          @existing_user_2
    end

    context "raise errors when" do
      it "text is not found" do
        expect do
          see @non_existing_user
        end.should raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "links" do
    before(:each) { visit('/texts.html') }

    it "by text" do
      see :link => 'What you want'
    end

    it "by text and url" do
      see :link => {"What I need" => '/what-i/need'}
    end

    it "many at once" do
      see :links => ['What you want', {"What I need" => '/what-i/need', "What I have" => '/what-i/have'}]
    end

    context "raise errors when" do
      it "link text doesn't isn't present" do
        expect do
          see :links => "What I Would like"
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
      it "url for link is different" do
        expect do
          see :link => {"What I need" => '/what-i/have'}
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end

  describe "Elements" do
    before(:each) { visit('/texts.html') }

    context "defined by" do
      it "default selector type" do
        see :element => "ul.pretty"
      end

      it "explicit selector type" do
        see :element => [:xpath, ".//ul[@class='pretty']"]
      end

      it "predefined area" do
        Kameleon::Session.stub!(:defined_areas).and_return({
                                                               :admin_menu => [:xpath, "//ul[@class='admin_menu']"]
                                                           })
        see :admin_menu
      end

      context "raise errors when" do
        it "element is not present" do
          expect do
            see :element => [:xpath, ".//image[@id='not_present']"]
          end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
        end
      end
    end
  end

end