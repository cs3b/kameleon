require 'spec_helper'

describe 'Scope' do

  before(:each) { visit('/scopes.html') }

  describe "using css and xpath selectors" do
    it "allow to pass block that will be evaluated " do
      within("#main") do
        see "Left side", "Right side"
      end

      within("#left") do
        see "Left side"
        not_see "Right side"
      end
    end

    it "handle xpath selector as well" do
      within(:xpath, "//*[@id='left']") do
        see "Left side"
        not_see "Right side"
      end
    end


    context "method chain (shortcut for case: when you only call one method within block)" do
      it "see" do
        within("#left").see "Left side"
        within("#right").not_see "Left side"
      end

      it "click" do
        within("#underFooter").click "Show Me Lists"
        within("ul#menu").see 7 => "li"
      end

      context 'with many parameters passed to method' do
        it 'see' do
          within('#main').see 'Left side', 'Right side'
          within('#footer').not_see 'Left side', 'Right side'
        end
      end

      context "errors" do
        it "raise when element not found" do
          expect do
            within("#right").see "Left side"
          end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
        end
      end
    end

  end

  describe "defined areas" do
    before do
      Kameleon::Session.stub!(:defined_areas).and_return({
                                                             :default => [:xpath, "//*[@id='main']"],
                                                             :left => '#left',
                                                             :right => '#right',
                                                             :footer => '#footer'
                                                         })
    end

    it "when not defined will use default" do
      within do
        see 'Left', 'Right', 'Sample text in main part of page'
        not_see 'Sample text in footer', 'Sample title for page'
      end
    end

    it "can use on of defined area" do
      within(:footer) do
        see 'Sample text in footer', 'Simple text'
        not_see 'Left', 'Right'
      end
    end
  end

  describe "special selectors" do
    before(:each) { visit('/special_elements') }

    # maybe in some future
    #context "many selectors at once" do
    #  it 'should see in many selctors scope' do
    #    pending "it would require to change how capybara handle scopes - not as single object but as collection"
    #    within(:xpath, '//div[@id="footer"]/span | //div[@id="main"]/div[@id="left"]') do
    #      see 'Left side', 'Simple'
    #    end
    #  end
    #end

    describe "table" do
      context "row" do
        it "find row by text" do
          within(:row => 'Michal Czyz') do
            see "13.00", "13"
            not_see "17.00", "2"
          end
        end

        it "find position" do
          within(:row => 2) do
            see "13.00", "13"
            not_see "17.00", "2"
          end
        end
      end

      # maybe in some future
      #context "column" do
      #  it "find by text" do
      #    pending "it would require to change how capybara handle scopes - not as single object but as collection"
      #    within(:column => 'Selleo') do
      #      see "13.00", "2.00", "0.00"
      #      not_see "17.00", "5.00"
      #    end
      #  end
      #  it "find by position" do
      #    pending "it would require to change how capybara handle scopes - not as single object but as collection"
      #    within(:column => 3) do
      #      see "13.00", "2.00", "0.00"
      #      not_see "17.00", "5.00"
      #    end
      #  end
      #end

      context "row and column" do
        it "find by text" do
          within(:cell => ['Michal Czyz', 'NotHotel']) do
            see "7.00"
            not_see "13.00", "19.61"
          end
        end

        it "find by position" do
          within(:cell => [2, 5]) do
            see "7.00"
            not_see "13.00", "19.61"
          end
        end
      end
    end
  end

  describe "chaining many selectors in one within for" do
    it "default selectors" do
      within("#main", ".important") do
        see "Left side"
        not_see "Right side"
      end
    end

    it "default and explicit defined selector" do
      within("#main", [:xpath, ".//*[@class='important']"]) do
        see "Left side"
        not_see "Right side"
      end
    end

    context "special selectors" do
      before(:each) do
        Kameleon::Session.stub!(:defined_areas).and_return({
                                                               :default => [:xpath, "//*[@id='main']"],
                                                               :left => '#left',
                                                               :right => '#right',
                                                               :footer => '#footer'
                                                           })
      end

      it "many special selectors" do
        within(:default, :right) do
          not_see "Left side"
          see "Right side"
        end
      end

      it "explicit defined and special selector" do
        within(:footer, "span") do
          see "Simple text"
          not_see "Sample text in footer"
        end
      end
    end

  end
end


#describe '#on_hover' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/on_hover.html')
#  end
#
#  pending do
#    context 'trigger hover event on element' do
#      it 'should trigger by css selector' do
#        @user.on_hover('#second') do
#          see 'Further information:'
#          not_see 'Second option', 'First option'
#        end
#      end
#
#      it 'should trigger by xpath selector' do
#        @user.on_hover(:xpath, '//p[@id="second"]') do
#          see 'Further information:'
#          not_see 'Second option', 'First option'
#        end
#      end
#    end
#
#    context 'when element does not exist' do
#      it 'should raise error' do
#        expect do
#          @user.on_hover('#doesNotExist') {}
#        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
#      end
#    end
#  end
#end
