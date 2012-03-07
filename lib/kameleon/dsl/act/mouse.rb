module Kameleon
  module DSL
    module Act
      module Mouse
        class Click
          attr_reader :params
          attr_reader :actions

          def initialize(*params)
            @params = params
            @actions = []
            parse_actions
          end

          private

          def parse_actions
            prepare_actions(params)
          end

          def prepare_actions(param)
            case param
              when String
                actions << Action.new(:click_on, param)
              when Hash
                param.each_pair do |type, values|
                  case type
                    when :non_implemented
                      raise "not implemented"
                    else
                      raise "not implemented"
                  end
                end
              when Array
                params.each { |parameter| prepare_actions(parameter) }
              else
                raise "not implemented"
            end
          end
        end
      end

      class Action
        attr_accessor :method, :params, :block

        def initialize(method, *params, &block)
          @method = method
          @params = params
          @block = block
        end
      end
    end
  end
end

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