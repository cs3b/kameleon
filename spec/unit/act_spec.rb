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


    <label for="prependedInput2">
       Prepended Checkbox
       <input type="checkbox" size="16" name="prependedInput2" id="prependedInput2" class="mini">
   </label>
    <label class="add-on"></label>


    <label for="prependedInput3">Awesome Checkbox</label>
    <input type="checkbox" size="16" name="prependedInput3" id="prependedInput3" class="mini">




    <label for="appendedInput">Appended checkbox</label>
    <label class="add-on active"><input type="checkbox" value="" id="appendedInput" name="">

    <label for="some_checkbox_one">Some checkbox</label>
    <input type="checkbox" checked="checked" value="" id="some_checkbox_one" name="">
    <label for="some_checkbox_two">Another checkbox</label>
    <input type="checkbox" checked="checked" value="" id="some_checkbox_two" name="">
    <label for="some_checkbox_three">And One More Checkbox</label>
    <input type="checkbox" checked="checked" value="" id="some_checkbox_three" name="">

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

    context "check box" do
      it "selecting" do
        @user.will do
          see :unchecked => ["Prepended Checkbox", "Appended checkbox", "Awesome Checkbox"]
          fill_in :check => ["Appended checkbox", "Awesome Checkbox"]
          session.save_and_open_page
          see :checked => ["Appended checkbox", "Awesome Checkbox"],
              :unchecked => "Prepended Checkbox"
        end
      end

      it "unselecting" do
        @user.will do
          see :checked => ["Some checkbox", "Another checkbox", "And One More Checkbox"]
          fill_in :uncheck => ["And One More Checkbox", "Some checkbox"]
          see :unchecked => ["And One More Checkbox", "Some checkbox"],
              :checked => "Another checkbox"
        end
      end
    end
  end
end