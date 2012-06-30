require 'spec_helper'

describe "Session" do
  describe "switch" do
    before do
      # we use :default session
      visit('/texts')

      # create new session with identifier ':user'
      create_session(:user)
      visit('/')
    end

    it "always available - possible to switch between sessions if you know id" do
      # switch session
      act_as(:default)
      see 'This is simple app', 'in that app'
      not_see 'Home'

      # swith session temporary (inside block)
      act_as(:user) do
        not_see 'This is simple app', 'in that app'
        see 'Home'
      end

      # block should not change session globally
      see 'This is simple app', 'in that app'
      not_see 'Home'
    end

    it "temporary switch session for single method call" do
      act_as(:user).see 'Home'
      act_as(:default).see 'in that app'
      act_as(:user).not_see 'in that app'
      act_as(:default).not_see 'Home'
    end
  end

  describe 'creating multiple sessions at once' do
    before do
      create_sessions(:admin, :user)
      visit '/'
    end

    it 'should work on the last created session by default' do
      not_see 'This is simple app', 'in that app'
      see 'Home'

      act_as(:user) do
        not_see 'This is simple app', 'in that app'
        see 'Home'
      end
    end

    it 'should work on all created sessions' do
      act_as(:admin) do
        visit '/texts'
        see 'This is simple app', 'in that app'
        not_see 'Home'
      end

      act_as(:user) do
        not_see 'This is simple app', 'in that app'
        see 'Home'
      end
    end
  end

  describe "Drivers" do

  end

  describe "Pool" do
    pending "not sure how to test pools properly" do
    end
  end
end
