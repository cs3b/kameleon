require 'spec_helper'

describe "Kameleon::User::Base" do
  include ::Capybara::DSL

  before(:all) do
    Capybara.app = Hey.new("Hello You :-)")
  end

  #! overwriting using block for initialization
end