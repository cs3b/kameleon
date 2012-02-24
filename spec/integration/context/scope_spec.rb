require 'spec_helper'

#describe '#see in scopes' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/scopes.html')
#  end
#
#  # TODO
#  # would be nice to be possible in future
#  # it's hard because of block closing
#  # it "should see within specific selector" do
#  #   @user.within("#some_div").see "This is It"
#  #   @user.within("#some_div").not_see "Hello"
#  # end
#  #
#  # it "should see within default selector" do
#  #   @user.stub!(:page_areas).and_return({:main => '#some_div'})
#  #   @user.will.see "This is It"
#  #   @user.will.not_see "Hello"
#  # end
#
#  context '#will' do
#    context 'when main selector was defined' do
#      before { @user.stub!(:page_areas).and_return({:main => '#main'}) }
#
#      it 'should see in main selector scope' do
#        @user.will do
#          see 'Sample text in main part of page', 'Left side', 'Right side'
#        end
#      end
#    end
#
#    context 'main selector was not defined' do
#      it 'should see in whole page scope' do
#        @user.will do
#          see 'Sample title for page', 'Sample text in top of page', 'Left side'
#        end
#      end
#    end
#  end
#
#  context '#within' do
#    it 'should see in css scope' do
#      @user.within('#top h1') do
#        see 'Sample title for page'
#      end
#    end
#
#    context 'when scope by xpath' do
#      it 'should see in one selector scope' do
#        @user.within(:xpath, '//div[@id="footer"]/span') do
#          see 'Simple text'
#        end
#      end
#
#      it 'should see in many selctors scope' do
#        user = Kameleon::User::Guest.new(self, :driver => :rack_test)
#        user.debug.visit('/scopes.html')
#        user.within(:xpath, '//div[@id="footer"]/span | //div[@id="main"]/div[@id="left"]', :select_multiple) do
#          see 'Simple text', 'Left side'
#        end
#      end
#    end
#
#    context 'when scope by default selector type' do
#      before do
#        @user.stub!(:page_areas).and_return({:top => '#top',
#                                             :footer => [:xpath, '//div[@id="footer"]']})
#      end
#
#      it 'should see in top selector scope' do
#        @user.within(:top) do
#          see 'Sample title for page', 'Sample text in top of page'
#        end
#      end
#
#      it 'should see in footer selector scope' do
#        @user.within(:footer) do
#          see 'Sample text in footer', 'Simple text'
#        end
#      end
#    end
#  end
#end


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

#describe '#see special selectors in tables' do
#
#  context 'when in row' do
#    before do
#      @user = Kameleon::User::Guest.new(self)
#      @user.debug.visit('/special_elements.html')
#    end
#    it 'should see full text' do
#      @user.within(:row => 'Michal Czyz') do
#        see "13.00"
#      end
#    end
#
#    it 'should see partial text' do
#      @user.within(:row => 'Michal Czyz') do
#        see "13"
#      end
#    end
#  end
#
#  context 'when in column' do
#    before do
#      @user = Kameleon::User::Guest.new(self, :driver => :rack_test)
#      @user.debug.visit('/special_elements.html')
#    end
#    context 'when scoped by full text' do
#      it 'should see full text' do
#        @user.within(:column => 'Selleo') do
#          see "13.00", "2.00", "0.00"
#        end
#      end
#
#      it 'should see partial text' do
#        @user.within(:column => 'Selleo') do
#          see "13", "2", "0"
#        end
#      end
#    end
#
#    context 'when scoped by partial text' do
#      it 'should see full text' do
#        @user.within(:column => 'lleo') do
#          see "13.00", "2.00", "0.00"
#        end
#      end
#
#      it 'should see partial text' do
#        @user.within(:column => 'lleo') do
#          see "13", "2", "0"
#        end
#      end
#    end
#  end
#end

#describe '#not_see in scopes' do
#  before do
#    @user = Kameleon::User::Guest.new(self)
#    @user.debug.visit('/scopes.html')
#  end
#
#  context '#will' do
#    context 'when main selector was defined' do
#      before { @user.stub!(:page_areas).and_return({:main => '#main'}) }
#
#      it 'should not see in main selector scope' do
#        @user.will do
#          not_see 'Sample title for page', 'Sample text in footer'
#        end
#      end
#    end
#  end
#
#  context '#within' do
#    it 'should not see in css scope' do
#      @user.within('#top h1') do
#        not_see 'Sample text in top of page', 'Left side'
#      end
#    end
#
#    context 'when scope by xpath' do
#      it 'should not see in one selector scope' do
#        @user.within(:xpath, '//div[@id="footer"]/span') do
#          not_see 'Sample text in footer', 'Sample text in main part of page'
#        end
#      end
#
#      it 'should not see in many selctors scope' do
#        @user = Kameleon::User::Guest.new(self, :driver => :rack_test)
#        @user.debug.visit('/scopes.html')
#        @user.within(:xpath, '//div[@id="footer"]/span | //div[@id="main"]/div[@id="left"]', :select_multiple) do
#          not_see 'Right side', 'Sample text in top of page', 'Sample text in footer'
#        end
#      end
#    end
#
#    context 'when scope by default selector type' do
#      before do
#        @user.stub!(:page_areas).and_return({:top => '#top',
#                                             :footer => [:xpath, '//div[@id="footer"]']})
#      end
#
#      it 'should not see in top selector scope' do
#        @user.within(:top) do
#          not_see 'Sample text in main part of page', 'Sample text in footer'
#        end
#      end
#
#      it 'should not see in footer selector scope' do
#        @user.within(:footer) do
#          not_see 'Sample title for page', 'Sample text in main part of page'
#        end
#      end
#    end
#  end
#end

