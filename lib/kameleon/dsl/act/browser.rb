

#def visit(page)
#  session.visit(page)
#end

#def refresh_page
#  case session.driver.class.name
#    when 'Capybara::Selenium::Driver', 'Capybara::RackTest::Driver'
#      visit session.driver.browser.current_url
#    when 'Capybara::Culerity::Driver'
#      session.driver.browser.refresh
#    else
#      raise 'unsupported driver'
#  end
#end