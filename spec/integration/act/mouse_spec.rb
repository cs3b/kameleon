require 'spec_helper'

describe "mouse" do
  describe "left click" do
    before(:each) { visit('/click') }

    it "allow to chain clicks" do
      not_see "and there is many lines"
      click "Load Next Page", "Texts"
      see "and there is many lines"
    end

    context "confirmation popups" do
      it "confirm" do
        see "This is simple app"
        click :and_accept => 'Save changes'
        not_see "This is simple app"
        see "Example form legend"
      end

      it "dismiss" do
        see "This is simple app"
        click :and_dismiss => 'Save changes'
        see "This is simple app"
      end
    end

    context "element defined by" do
      it "default selector type" do
        not_see "and there is many lines"
        click :element => "#text_link"
        see "and there is many lines"
      end

      it "explicit selector type" do
        not_see "and there is many lines"
        click :element => [:xpath, ".//a[@id='text_link']"]
        see "and there is many lines"
      end

      it "predefined area" do
        Kameleon::Session.stub!(:defined_areas).and_return({
                                                               :homepage_link => [:xpath, "//a[@id='homepage_link']"]
                                                           })

        not_see "Welcome on Home Page"
        click :homepage_link
        see "Welcome on Home Page"
      end

      it "object with to_s method" do
        user = DummyUser.new("Michal", "Czyz")
        click user
        see "and there is many lines"
      end
    end

    it "image defined by alt" do
      not_see "in that app"
      click :image => 'help'
      see "in that app"
    end

    context "raise error when" do
      it "one of link doesn't exists" do
        expect do
          click 'Load Next Page', 'Submit'
        end.to raise_error(Capybara::ElementNotFound)
      end
    end
  end
end