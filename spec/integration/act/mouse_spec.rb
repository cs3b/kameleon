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
        pending
        click :and_accept => 'Confirm button'
      end

      it "dismiss" do
        pending
        click :and_dismiss => 'Confirm button'
      end
    end

    context "element defined by" do
      it "default selector type" do
        pending
        click :element => "#some_id"
      end

      it "explicit selector type" do
        pending
        click :element => [:xpath, ".//image[@id='some_id'"]
      end
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