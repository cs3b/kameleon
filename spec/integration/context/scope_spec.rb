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

    pending do
      it "allow to method chain with i.e. verification dsl" do
        within("#left").see "Left side"
        within("#right").not_see "Left side"
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

    it "allow to method chain with default selector" do
      pending "Need Context::Proxy object"
      within.see 'Left', 'Right', 'Sample text in main part of page'
      within.not_see 'Sample text in footer', 'Sample title for page'
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

    pending do
      context "multi-select" do
        it 'should see in many selctors scope' do
          within(:xpath, '//div[@id="footer"]/span | //div[@id="main"]/div[@id="left"]') do
            see 'Left side', 'Simple'
          end
        end
      end
    end

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

      pending do
        context "column" do
          it "find by text" do
            within(:column => 'Selleo') do
              see "13.00", "2.00", "0.00"
              not_see "17.00", "5.00"
            end
          end
          it "find by position" do
            within(:column => 3) do
              see "13.00", "2.00", "0.00"
              not_see "17.00", "5.00"
            end
          end
        end
      end

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