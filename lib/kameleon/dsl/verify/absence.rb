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
            when Hash
              param.each_pair do |type, values|
                case type
                  when :link, :links
                    conditions.concat Link.new(values).conditions
                  when :image, :images
                    conditions.concat Image.new(values).conditions
                  when :field, :fields
                    conditions.concat Field.new(values).conditions
                  else
                    raise "not implemented"
                end
              end
            when Array
              params.each { |parameter| prepare_conditions(parameter) }
            else
              raise "not implemented"
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


        class Link
          attr_reader :conditions

          def initialize(params)
            @conditions = []
            parse_params(params)
          end

          private

          def parse_params(params)
            case params
              when Hash
                params.each_pair do |text, url|
                  conditions << Condition.new(:have_no_link, text, :href => url)
                end
              when String
                conditions << Condition.new(:have_no_link, params)
              when Array
                params.each { |param| parse_params(param) }
              else
                raise 'not implemented'
            end
          end
        end

        class Image
          attr_reader :conditions

          def initialize(params)
            @conditions = []
            parse_params(params)
          end

          private

          def parse_params(params)
            case params
            when String
              conditions << Condition.new(:have_no_xpath, prepare_xpath(params))
              when Array
                params.each { |param| parse_params(param) }
              else
                raise 'not implemented'
            end
          end

          def prepare_xpath(alt_or_src)
            "//img[@alt=\"#{alt_or_src}\"] | //img[@src=\"#{alt_or_src}\"]"
          end
        end

        class Field
          attr_reader :conditions

          def initialize(params)
            @conditions = []
            parse_params(params)
          end

          private

          def parse_params(params)
            case params
              when Hash
                params.each_pair do |text, url|
                  conditions << Condition.new(:have_no_field, text, :href => url)
                end
              when String
                conditions << Condition.new(:have_no_field, params)
              when Array
                params.each { |param| parse_params(param) }
              else
                raise 'not implemented'
            end
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
#          when :field, :fields
#            one_or_all(locators).each do |locator|
#              session.should_not rspec_world.have_field(locator)
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