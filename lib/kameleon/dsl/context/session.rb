#def will(&block)
#  default_selector ?
#      within(*default_selector, &block) :
#      instance_eval(&block)
#end

#def debug
#  session
#end

#private
#def session
#  @session
#end

#def set_session
#  @session = ::SessionPool.session(current_driver)
#end
#
#
#
#private
#
#def current_session
#  ::Capybara.current_session
#end
#
#def current_driver
#  driver_name ||
#      ::Capybara.current_driver
#end