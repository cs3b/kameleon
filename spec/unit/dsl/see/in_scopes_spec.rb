require 'spec_helper'

describe '#see in scopes' do
  before do
    Capybara.app = Hey.new('scopes.html')
    @user = Kameleon::User::Guest.new(self)
  end

  # TODO
  # would be nice to be possible in future
  # it's hard because of block closing
  # it "should see within specific selector" do
  #   @user.within("#some_div").see "This is It"
  #   @user.within("#some_div").not_see "Hello"
  # end
  #
  # it "should see within default selector" do
  #   @user.stub!(:page_areas).and_return({:main => '#some_div'})
  #   @user.will.see "This is It"
  #   @user.will.not_see "Hello"
  # end

  context '#will' do
    context 'when main selector was defined' do
      before { @user.stub!(:page_areas).and_return({:main => '#main'}) }

      it 'should see in main selector scope' do
        @user.will do
          see 'Sample text in main part of page', 'Left side', 'Right side'
        end
      end
    end

    context 'main selector was not defined' do
      it 'should see in whole page scope' do
        @user.will do
          see 'Sample title for page', 'Sample text in top of page', 'Left side'
        end
      end
    end
  end

  context '#within' do
    it 'should see in css scope' do
      @user.within('#top h1') do
        see 'Sample title for page'
      end
    end

    context 'when scope by xpath' do
      it 'should see in one selector scope' do
        @user.within(:xpath, '//div[@id="footer"]/span') do
          see 'Simple text'
        end
      end

      it 'should see in many selctors scope' do
        @user.within(:xpath, '//div[@id="footer"]/span | //div[@id="main"]/div[@id="left"]', :select_multiple) do
          see 'Simple text', 'Left side'
        end
      end
    end

    context 'when scope by default selector type' do
      before do
        @user.stub!(:page_areas).and_return({:top => '#top',
                                             :footer => [:xpath, '//div[@id="footer"]']})
      end

      it 'should see in top selector scope' do
        @user.within(:top) do
          see 'Sample title for page', 'Sample text in top of page'
        end
      end

      it 'should see in footer selector scope' do
        @user.within(:footer) do
          see 'Sample text in footer', 'Simple text'
        end
      end
    end
  end
end
