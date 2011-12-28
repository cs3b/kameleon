# encoding: utf-8

require 'spec_helper'

describe "See" do
  include ::Capybara::DSL

  before(:all) do
    Capybara.app = Hey.new(%q{
    <h1>This is simple app</h1>
    <p>and there is many lines</p>
    <p>i that app</p>

      <a href="/i-want/to">What you want</a>

      <a href="/what-i/need">What I need</a>

      <img src="/images/logo_diamondmine.png?1324293836" alt="Logo_diamondmine">

      <form>
        <fieldset>
          <legend>Example form legend</legend>
            <label for="xlInput">X-Large input</label>
              <input type="text" size="30" name="xlInput" id="xlInput" value="this is great value" class="xlarge">
              <input type="text" size="30" name="xlInput" id="xlInput_two" value="" class="xlarge">
              <input type="text" size="30" name="xlInput" id="xlInput_three" value="" class="xlarge">

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
            <div id="some_labels" class="input">
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


      <table cellspacing="0" cellpadding="0" class="generic summary vertical_header">
            <thead>
              <tr>
                  <th class="lc"></th>
                  <th class="left">Resource</th>
                  <th title="Selleo" class="vertical"><span>Selleo</span></th>
                  <th title="Selleo Improvements" class="vertical"><span>Selleo&nbsp;Impr...</span></th>
                  <th title="NotHotel" class="vertical"><span>NotHotel</span>
                  <th class="rc"></th>
              </tr>
            </thead>

            <tfoot>
              <tr>
                <td class="lc"></td>
                <td colspan="19"></td>
                <td class="rc"></td>
              </tr>
            </tfoot>

            <tbody>

        <tr class="odd total" id="">

          <td class="lb"></td>

                      <td class="ta_l">Total:</td>

                      <td scope="project_16" class="calculation sum"><span><b>21.77</b></span></td>

                      <td scope="project_99" class="calculation sum"><span><b>1.75</b></span></td>

                      <td scope="project_44" class="calculation sum"><span><b>19.61</b></span></td>

          <td class="rb">
          </td>

        </tr>

        <tr class="even " id="">

          <td class="lb"></td>

                          <td class="ta_l">Michał Czyż</td>
                          <td scope="x_project_16"><span class="zero">13.00</span></td>
                          <td scope="x_project_84"><span class="zero">9.00</span></td>
                          <td scope="x_project_62"><span class="zero">7.00</span></td>
          <td class="rb">
          </td>

        </tr>

        <tr class="odd " id="">

          <td class="lb"></td>

                          <td class="ta_l">Tomasz Bąk</td>
                          <td scope="x_project_16"><span class="zero">2.00</span></td>
                          <td scope="x_project_84"><span class="zero">17.00</span></td>
                          <td scope="x_project_62"><span class="zero">8.00</span></td>

         <td class="rb">
         </td>

        </tr>

        <tr class="even " id="">

          <td class="lb"></td>

                          <td class="ta_l">Rafał Bromirski</td>
                          <td scope="x_project_16"><span class="zero">0.00</span></td>
                          <td scope="x_project_84"><span class="zero">5.00</span></td>
                          <td scope="x_project_62"><span class="zero">19.00</span></td>

          <td class="rb">
          </td>

        </tr>

            </tbody>
          </table>
                           })
    @user = Kameleon::User::Guest.new(self)
  end

  context "text in site" do
    context "I can recognize links" do
      it "see when they are placed" do
        @user.see :link => {'What you want' => '/i-want/to'}
      end
      it "throw error if not found" do
        lambda {
          @user.see :link => {'What I need' => '/no-way'}
        }.should raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end

    context "can count things" do
      it "by css" do
        @user.within("#normalSelect") do
          see 5 => 'option'
        end
      end

      it "by xpath from page areas" do
        @user.stub!(:page_areas).and_return({:some_labels => [:xpath, '//div[@id="some_labels"]/label']})
        @user.see 2 => :some_labels
      end

      it "show error when there is no match" do
        lambda {
          @user.within("#normalSelect") do
            see 3 => 'option'
          end
        }.should raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end

    context "elements in" do
      context "colums" do
        it "will see scoped by table header" do
          @user.within(:column => 'Selleo') do
            see "13.00", "2.00", "0.00"
            not_see "19.00", "17.00", "5.00", "7.00", "9.00"
          end
        end
        it "will see scoped by part of header" do
          @user.within(:column => 'lleo') do
            see "13.00", "2.00", "0.00"
            not_see "19.00", "17.00", "5.00", "7.00", "9.00"
          end
        end

        it "should also see elements in header" do
          @user.within(:column => 'lleo') do
            see "Selleo"
          end
        end
      end
      context "rows" do
        it "see only elements in row" do
          @user.within(:row => 'Michał Czyż') do
            see "13.00"
            not_see "17.00"
          end
        end
      end
    end

    context "images" do
      it "see by alt" do
        @user.see :image => "Logo_diamondmine"
      end

      it "see by src" do
        @user.see :image => "/images/logo_diamondmine.png?1324293836"
      end
    end

    context "elements in order" do
      it "see them all" do
        @user.see :ordered => ['Michał Czyż', 'Tomasz Bąk', 'Rafał Bromirski']
      end

      it "show error if not" do
        lambda {
        @user.see :ordered => ['Tomasz Bąk', 'Michał Czyż', 'Rafał Bromirski']
        }.should raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
