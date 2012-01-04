class TestUserAdministrator < Kameleon::User::Base
  def initialize(rspec_world, options={})
    @user = Factory(:admin_user, :email => "c@example.com")
    super
  end

  def page_areas
    {
        :users_table => 'table#listing_users'
    }
  end

  private
  def user_login_path
    rspec_world.login_path
  end
end