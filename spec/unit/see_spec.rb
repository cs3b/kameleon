require 'spec_helper'

describe "See" do
  include ::Capybara::DSL

  before(:all) do
    Capybara.app = Hey.new(%q{
    <h1>This is simple app</h1>
    <p>and there is many lines</p>
    <p>i that app</p>
    <input>
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

    end
  end
end