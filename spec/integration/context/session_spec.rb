require 'spec_helper'

describe "Session" do
  it "always available - possible to switch between sessions if you know id" do
    # we use :default session
    load_page('/texts')

    # create new session with identifier ':user'
    create_session(:user)
    load_page

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

  describe "Drivers" do

  end

  describe "Pool" do
    pending "not sure how to test pools properly" do
    end
  end
end