module Kameleon
  module DSL
    module Verify
      class Absence

        attr_accessor :conditions, :params

        def initialize(*params)
          @params = params
          @conditions = []

          parse_conditions
        end

        private

        def parse_conditions
          prepare_conditions(params)
        end

        def prepare_conditions(param)
          case param
            when String
              conditions << Condition.new(:have_no_content, param)
            when Array
              params.each { |parameter| prepare_conditions(parameter) }
          end
        end

        class Condition
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
end


#def not_see(*content)
#  options = extract_options(content)
#
#  case options.class.name
#    when 'String'
#      session.should_not rspec_world.have_content(options)
#    when 'Array'
#      options.each do |content_part|
#        session.should_not rspec_world.have_content(content_part)
#      end
#    when 'Hash'
#      options.each_pair do |value, locators|
#        case value
#          when :button, :buttons
#            one_or_all(locators).each do |selector|
#              session.should_not rspec_world.have_button(selector)
#            end
#          when :error_message_for, :error_messages_for
#            one_or_all(locators).each do |selector|
#              session.find(:xpath, '//div[@id="error_explanation"]').should_not rspec_world.have_content(selector.capitalize)
#            end
#          when :image, :images
#            one_or_all(locators).each do |selector|
#              session.should_not rspec_world.have_xpath("//img[@alt=\"#{selector}\"] | //img[@src=\"#{selector}\"]")
#            end
#          when :field, :fields
#            one_or_all(locators).each do |locator|
#              session.should_not rspec_world.have_field(locator)
#            end
#          when :link, :links
#            if locators.respond_to?(:each_pair)
#              locators.each_pair do |link_text, url|
#                session.should_not rspec_world.have_link(link_text, :href => url)
#              end
#            else
#              one_or_all(locators).each { |text| session.should_not rspec_world.have_link(text) }
#            end
#          when :ordered
#            nodes = session.all(:xpath, locators.collect { |n| "//node()[text()= \"#{n}\"]" }.join(' | '))
#            nodes.map(&:text).should_not == locators
#          when :readonly
#            one_or_all(locators).each do |selector|
#              see :field => selector
#              case session.driver
#                when Capybara::Selenium::Driver
#                  session.find_field(selector)[value].should == 'false'
#                when Capybara::RackTest::Driver
#                  session.find_field(selector)[value].should rspec_world.be_nil
#              end
#            end
#          when :empty
#            one_or_all(locators).each do |locator|
#              see :field => locator
#              session.find_field(locator).value.to_s.should_not == ''
#            end
#          else
#            one_or_all(locators).each do |locator|
#              session.should_not rspec_world.have_field(locator, :with => value)
#            end
#        end
#      end
#    else
#      raise "Not Implemented Structure #{options} :: #{options.class}"
#  end
#end