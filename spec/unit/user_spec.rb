require 'spec_helper'

describe "Kameleon::User::Guest" do
  include Capybara::DSL


  context "guest user" do
    before(:all) do
      @guest = Kameleon::User::Guest.new(self, {:session_name => :see_world})
      @another_guest = Kameleon::User::Guest.new(self)
    end

    context "sessions" do
      it "by default user should get current session" do
        @another_guest.session.should == Capybara.current_session
      end

      it "guests should have separate session if param :session_name defined" do
        @guest.session.should_not == Capybara.current_session
      end
    end
  end
end