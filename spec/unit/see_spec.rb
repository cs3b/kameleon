require 'spec_helper'

describe "See" do
  include ::Capybara::DSL

  before(:all) do
    Capybara.app = Hey.new(%q{
    <h1>This is simple app</h1>
    <p>and there is many lines</p>
    <p>i that app</p>

      <form>
        <fieldset>
          <legend>Example form legend</legend>
            <label for="xlInput">X-Large input</label>
              <input type="text" size="30" name="xlInput" id="xlInput" value="this is great value" class="xlarge">

            <label for="normalSelect">Select</label>
              <select id="normalSelect" name="normalSelect">
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
              </select>

            <label for="mediumSelect">Select</label>
              <select id="mediumSelect" name="mediumSelect" class="medium">
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
              </select>
            <label for="multiSelect">Multiple select</label>
              <select id="multiSelect" name="multiSelect" multiple="multiple" size="5" class="medium">
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
              </select>

            <label for="disabledInput">Disabled input</label>
              <input type="text" disabled="" placeholder="Disabled input here carry on." size="30" name="disabledInput" id="disabledInput" class="xlarge disabled">

            <label for="disabledInput">Disabled textarea</label>
              <textarea disabled="" rows="3" id="textarea" name="textarea" class="xxlarge"></textarea>
        </fieldset>

        <fieldset>
            <label for="prependedInput">Prepended text</label>
                <input type="text" size="16" name="prependedInput" id="prependedInput" class="medium">

            <label for="prependedInput2">Prepended checkbox</label>
                <label class="add-on"><input type="checkbox" value="" id="" name=""></label>
                <input type="text" size="16" name="prependedInput2" id="prependedInput2" class="mini">

            <label for="appendedInput">Appended checkbox</label>
                <input type="text" size="16" name="appendedInput" id="appendedInput" checked="checked" class="mini">
                <label class="add-on active"><input type="checkbox" checked="checked" value="" id="" name=""></label>

            <label for="fileInput">File input</label>
              <input type="file" name="fileInput" id="fileInput" class="input-file">
        </fieldset>

        <fieldset>
            <label id="optionsCheckboxes">List of options</label>

                  <label>
                    <input type="checkbox" value="option1" name="optionsCheckboxes_one">
                    <span>Option one is this and that&mdash;be sure to include why it's great</span>
                  </label>

                  <label>
                    <input type="checkbox" value="option2" checked="checked" name="optionsCheckboxes_two">
                    <span>Option two can also be checked and included in form results</span>
                  </label>

                  <label>
                    <input type="checkbox" value="option2" name="optionsCheckboxes">
                    <span>Option three can&mdash;yes, you guessed it&mdash;also be checked and included in form results. Let's make it super long so that everyone can see how it wraps, too.</span>
                  </label>

                  <label class="disabled">
                    <input type="checkbox" disabled="" value="option2" name="optionsCheckboxes">
                    <span>Option four cannot be checked as it is disabled.</span>
                  </label>

            <label>Date range</label>
              <div class="inline-inputs">
                <input type="text" value="May 1, 2011" class="small">
                <input type="text" value="12:00am" class="mini">
                to
                <input type="text" value="May 8, 2011" class="small">
                <input type="text" value="11:59pm" class="mini">
                <span class="help-block">All times are shown as Pacific Standard Time (GMT -08:00).</span>
              </div>

            <label for="textarea">Textarea</label>
              <textarea rows="3" name="textarea2" id="textarea2" class="xxlarge"></textarea>

            <label id="optionsRadio">List of options</label>
            <div class="input">
                  <label>
                    <input type="radio" value="option1" name="optionsRadios" checked="">
                    <span>Option one is this and that&mdash;be sure to include why it's great</span>
                  </label>

                  <label>
                    <input type="radio" value="option2" name="optionsRadios">
                    <span>Option two can is something else and selecting it will deselect options 1</span>
                  </label>
            </div>

            <input type="submit" value="Save changes" class="btn primary">&nbsp;<button class="btn" type="reset">Cancel</button>

        </fieldset>
      </form>
                           })
    @user = Kameleon::User::Guest.new(self)
  end

  context "and can judge that there is no text on site" do
    it "with single param" do
      @user.not_see "cool rails app"
    end

    it "with multiple params at once" do
      @user.not_see "sinatra app",
                    "padrino app"
    end

    it "it will fail if at least one text is visibile" do
      lambda {
        @user.not_see "sinatra app",
                      "This is simple app"
      }.should raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context "text in site" do
    it "when single parameter" do
      @user.see "This is simple app"
    end

    it "when many strings" do
      @user.see "This is simple app",
                "and there is many lines",
                "i that app"
    end

    it "when many strings should fail if there is at least one missing" do
      lambda {
        @user.see("sinatra app",
                  "and there is many lines",
                  "i that app")
      }.should raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    context "that are value for form" do
      it "by input id" do
        @user.see 'this is great value' => 'xlInput'
      end

      it "by input label" do
        @user.see 'this is great value' => 'X-Large input'
      end
    end

    context "that are not value for form" do
      it "by input id" do
        @user.not_see 'this is not such a great value' => 'xlInput'
      end
    end

    context "values for checkbox'es" do
      context "veirfy status for single checkbox'es'" do
        context "is checked" do
          it "by Label" do
            @user.see :checked => "Appended checkbox"
          end
          it "by dom id" do
            @user.see :checked => "appendedInput"
          end
        end

        context "is unchecked" do
          it "by Label" do
            @user.see :unchecked => "Prepended checkbox"
          end
          it "by dom id" do
            @user.see :unchecked => "prependedInput"
          end
        end
      end

      context "should understand status for multiple checkbox'es'" do
        it "checked" do
          @user.see :checked => ["Appended checkbox", "appendedInput", "optionsCheckboxes_two"]
        end
        it "when unchecked" do
          @user.see :unchecked => ["Prepended checkbox", "optionsCheckboxes", "optionsCheckboxes_one"]
        end

        it "when not all are checked" do
          lambda {
          @user.see :checked => ["Appended checkbox", "appendedInput", "optionsCheckboxes_one"]
          }.should raise_error(RSpec::Expectations::ExpectationNotMetError)
        end
      end
    end
  end
end