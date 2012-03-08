require 'spec_helper'

describe "browser" do
  describe "refresh" do
    it "reload page" do
      visit('/form_elements')
      see :empty => 'textarea2'
      fill_in 'some text' => 'textarea2'
      see 'some text' => 'textarea2'

      refresh_page
      see :empty => 'textarea2'
    end
  end
  #! go_back
end
