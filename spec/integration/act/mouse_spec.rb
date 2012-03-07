require 'spec_helper'

describe "mouse" do
  describe "left click" do
    before(:each) { load_page('/click') }

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

    context "raise error when" do
      it "one of link doesn't exists" do
        expect do
          click 'Load Next Page', 'Submit'
        end.to raise_error(Capybara::ElementNotFound)
      end
    end
  end
end