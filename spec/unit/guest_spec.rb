require 'spec_helper'

describe "Kameleon::User::Guest" do
  include ::Capybara::DSL

  before(:all) do
    Capybara.app = Hey.new("Hello You :-) <div id=\"some_div\"> This is It</div>")
  end


  context "guest user" do
    before(:all) do
      @guest = Kameleon::User::Guest.new(self, {:session_name => :see_world})
      @another_guest = Kameleon::User::Guest.new(self)
    end

    context "sessions" do
      it "by default user should get current session" do
        @another_guest.send(:session).should == Capybara.current_session
        @another_guest.debug.should == Capybara.current_session
      end

      it "guests should have separate session if param :session_name defined" do
        @guest.debug.should_not == Capybara.current_session
      end
    end

    context "driver" do
      it "will not change if not defined in params" do
        @guest.debug.driver.should be_a Capybara.current_session.driver.class
      end

      context "selecting custom driver" do
        before(:all) do
          @selenium = Kameleon::User::Guest.new(self, {:session_name => :new_world, :driver => :selenium, :skip_page_autoload => true})
        end
        it "should set Selenium if params :driver => :selenium" do
          @selenium.debug.driver.should be_a Capybara::Selenium::Driver
        end
        it "shouldn't change drivers for other users'" do
          [@guest, @another_guest].each do |user|
            user.debug.driver.should be_a Capybara::RackTest::Driver
          end
        end
      end
    end
  end

  context "perform request" do
    before(:all) do
      @user = Kameleon::User::Guest.new(self)
    end

    it "should be able to see response" do
      @user.see("Hello")
    end

    it "using will block" do
      @user.will do
        see "Hello"
      end
    end

    it "should see within using block" do
      @user.within("#some_div") do
        see "This is It"
      end
    end

    it "should see within default selector" do
      @user.stub!(:page_areas).and_return({:main => '#some_div'})
      @user.will do
        see "This is It"
        not_see "Hello"
      end
    end

    it "should not see within" do
      @user.within("#some_div") do
        not_see "Hello"
      end
    end

    context "overwriting sector type" do
      it "should see within default selector" do
        @user.stub!(:page_areas).and_return({:main => [:xpath, '//div[@id="some_div"]']})
        @user.will do
          see "This is It"
          not_see "Hello"
        end
      end

      it "should not see within" do
        @user.within(:xpath, '//div[@id="some_div"]') do
          not_see "Hello"
        end
      end
    end


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
  end
end