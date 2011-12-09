require 'spec_helper'

describe "Act" do
  include ::Capybara::DSL

  before(:each) do
    Capybara.app = Hey.new(%q{
    <h1>This is simple app</h1>
    <a href="next_page.html">Load Next Page</a>
    <form>
    <label for="xlInput">X-Large input</label>
    <input type="text" size="30" name="xlInput" id="xlInput" value="this is great value" class="xlarge">

    <input type="submit" value="Save changes" class="btn primary">

    <button class="btn" type="reset">Cancel</button>

    </form>

    })
    @user = Kameleon::User::Guest.new(self)
  end

  it "clicks on link" do
    @user.click "Load Next Page"
  end

  it "clicks on buttons" do
    @user.click "Save changes"
  end

  it "allow to chain many clicks - with success" do
    @user.click "Save changes", "Load Next Page", "Save changes"
  end

  it "allow to chain many clicks - raise error, if at least one of them not found" do
    lambda {
    @user.click "Save changes", "Load Next Page", "Submit", "Load Next Page"
    }.should raise_error(Capybara::ElementNotFound)
  end

  context "fill in form" do
    it "set field value by id" do
      @user.not_see 'WoW' => 'xlInput'
      @user.fill_in 'WoW' => 'xlInput'
      @user.see 'WoW' => 'xlInput'
    end

    it "set field value by Label title" do
      @user.not_see 'WoW' => 'xlInput'
      @user.fill_in 'WoW' => 'X-Large input'
      @user.see 'WoW' => 'xlInput'
    end
  end
end