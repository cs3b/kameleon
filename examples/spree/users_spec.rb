#https://github.com/spree/spree/blob/master/core/spec/requests/admin/users_spec.rb

require 'spec_helper'

feature "Users" do

  background do
    Factory(:user, :email => "a@example.com")
    Factory(:user, :email => "b@example.com")

    @admin = TestUserAdministrator.new(self) do
      visit spree.admin_path
      click "Users"
    end
  end

  context "users index page with sorting" do
    background do
      @admin.click "users_email_title"
    end

    it "should be able to list users with order email asc" do
      @admin.see :users_table #TODO will it work?
      @admin.within(:users_table) do
        see "a@example.com", "b@example.com"
      end
    end

    it "should be able to list users with order email desc" do
      @admin.click "users_email_title"
      @admin.within(:users_table) do
        see "a@example.com", "b@example.com"
      end
    end
  end

  context "searching users" do
    it "should display the correct results for a user search" do
      @admin.fill_in("a@example.com" => "search_email_contains")
      @admin.click "Search"
      @admin.within(:users_table) do
        see "a@example.com", "b@example.com"
      end
    end
  end

  context "editing users" do

    background do
      @admin.click "a@example.com", "Edit"
    end

    it "should let me edit the user email" do
      @admin.fill_in("a@example.com99" => "user_email")
      @admin.click "Update"
      @admin.see "successfully updated!", "a@example.com99"
    end

    it "should let me edit the user password" do
      @admin.fill_in("welcome" => "user_password")
      @admin.fill_in("welcome" => "user_password_confirmation")
      @admin.click "Update"
      @admin.see "successfully updated!"
    end
  end
end
