require 'spec_helper'

describe "Session" do
  describe "switch" do
    before do
      # we use :default session
      load_page('/texts')

      # create new session with identifier ':user'
      create_session(:user)
      load_page
    end

    it "always available - possible to switch between sessions if you know id" do
      # switch session
      act_as(:default)
      see 'This is simple app', 'in that app'
      unseeing 'Home'

      # swith session temporary (inside block)
      act_as(:user) do
        unseeing 'This is simple app', 'in that app'
        see 'Home'
      end

      # block should not change session globally
      see 'This is simple app', 'in that app'
      unseeing 'Home'
    end

    it "temporary switch session for single method call" do
      act_as(:user).see 'Home'
      act_as(:default).see 'in that app'
      act_as(:user).unseeing 'in that app'
      act_as(:default).unseeing 'Home'
    end
  end

  describe "Drivers" do

  end

  describe "Pool" do
    pending "not sure how to test pools properly" do
    end
  end
end