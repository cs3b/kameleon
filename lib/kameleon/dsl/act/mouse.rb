#def click(*links)
#  links.each do |link|
#    case link.class.name
#      when 'String'
#        session.click_on(link)
#      when 'Hash'
#        link.each_pair do |what, locator|
#          case what
#            when :image
#              session.find(:xpath, "//img[@alt=\"#{locator}\"").click
#            when :and_accept
#              if session.driver.is_a?(Capybara::Selenium::Driver)
#                #! js hack - problem with selenium native alerts usage
#                #! it switch to allert but no reaction on accept or dismiss
#                session.evaluate_script("window.alert = function(msg) { return true; }")
#                session.evaluate_script("window.confirm = function(msg) { return true; }")
#              end
#              click(locator)
#            # session.driver.browser.switch_to.alert.accept if session.driver.is_a?(Capybara::Selenium::Driver)
#            when :and_dismiss
#              if session.driver.is_a?(Capybara::Selenium::Driver)
#                session.evaluate_script("window.alert = function(msg) { return true; }")
#                session.evaluate_script("window.confirm = function(msg) { return false; }")
#              end
#              click(locator)
#            # session.driver.browser.switch_to.alert.dismiss if session.driver.is_a?(Capybara::Selenium::Driver)
#            else
#              raise("User do not know how to click #{what} - you need to teach him how")
#          end
#        end
#    end
#  end
#end