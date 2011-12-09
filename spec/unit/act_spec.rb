require 'spec_helper'

describe "Act" do
  include ::Capybara::DSL

  before(:all) do
    Capybara.app = Hey.new(%q{
    <h1>This is simple app</h1>
    <a href="next_page.html">Load Next Page</a>
    <form>

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
end