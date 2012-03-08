#! TODO
#def initialize(rspec_world, options={}, &block)
#  super do
#    login
#  end
#  instance_eval(&block) if block_given?
#end
#
#def login
#  visit user_login_path
#  fill_in user_login => 'Email',
#          user_password => 'Password'
#  click 'Login'
#end
#
#private
#
#def user_login
#  user.email
#end
#
#def user_password
#  user.password
#end
#
#def user_login_path
#  new_session_path
#end