module Kameleon
  module DSL
    module Verify
      class Presence

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
              conditions << Condition.new(:have_content, param)
            when Hash
              param.each_pair do |type, values|
                case type
                  when :link, :links
                    conditions.concat Link.new(values).conditions
                  when :image, :images
                    conditions.concat Image.new(values).conditions
                  when :ordered
                    conditions.concat Sequence.new(values).conditions
                  when Fixnum
                    conditions.concat Quantity.new(type, values).conditions
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
                conditions << Condition.new(:have_link, text, :href => url)
              end
            when String
              conditions << Condition.new(:have_link, params)
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
              conditions << Condition.new(:have_xpath, prepare_xpath(params))
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

      class Quantity
        attr_reader :conditions
        attr_reader :quantity

        def initialize(quantity, params)
          @conditions = []
          @quantity = quantity
          parse_params(params)
        end

        private

        def parse_params(params)
          if params === Array && params.first == Array
            params.each { |param| parse_params(param) }
          else
            #! refactor
            selector = prepare_query(params).selector
            conditions << Condition.new(prepare_method(selector), selector.last, :count => quantity)
          end
        end

        def prepare_query(selector)
          Context::Scope.new(selector)
        end

        #! refactor - delagate to Context::Scope class
        def prepare_method(query)
          query.first == :xpath ?
              :have_xpath :
              :have_css
        end
      end

      class Sequence
        attr_reader :params

        def initialize(params)
          @params = params
        end


        def conditions
          [condition]
        end

        private

        def condition
          Condition.new(nil, params, prepare_xpath) do |elements, xpath_query|
            texts = page.all(:xpath, xpath_query).map(&:text)
            texts.should == elements
          end
        end

        def prepare_xpath
          params.collect { |n| "//node()[text()= \"#{n}\"]" }.join(' | ')
        end
      end
    end

  end
end

#def see(*content)
#  options = extract_options(content)
#
#  case options.class.name
#    when 'String'
#      session.should rspec_world.have_content(options)
#    when 'Array'
#      options.each do |content_part|
#        see(content_part)
#      end
#    when 'Hash'
#      options.each_pair do |value, locator|
#        case value.class.name
#          when 'Symbol'
#            case value
#              when :button, :buttons
#                one_or_all(locator).each do |selector|
#                  session.should rspec_world.have_button(selector)
#                end
#              when :checked, :unchecked
#                one_or_all(locator).each do |selector|
#                  session.should rspec_world.send("have_#{value.to_s}_field", selector)
#                end
#              when :disabled, :readonly
#                one_or_all(locator).each do |selector|
#                  see :field => selector
#                  case session.driver
#                    when Capybara::Selenium::Driver
#                      session.find_field(selector)[value].should == 'true'
#                    when Capybara::RackTest::Driver
#                      session.find_field(selector)[value].should ==(value.to_s)
#                  end
#                end
#              when :empty
#                one_or_all(locator).each do |selector|
#                  see :field => selector
#                  session.find_field(selector).value.to_s.should == ''
#                end
#              when :error_message_for, :error_messages_for
#                one_or_all(locator).each do |selector|
#                  session.find(:xpath, '//div[@id="error_explanation"]').should rspec_world.have_content(selector.capitalize)
#                end
#              when :field, :fields
#                one_or_all(locator).each do |selector|
#                  session.should rspec_world.have_field(selector)
#                end

#                end
#              when :selected
#                locator.each_pair do |selected_value, selected_locator|
#                  session.should rspec_world.have_select(selected_locator, :selected => selected_value)
#                end
#              when :unselected
#                locator.each_pair do |selected_value, selected_locator|
#                  session.should rspec_world.have_no_select(selected_locator, :selected => selected_value)
#                end
#              when :link, :links
#                if locator.respond_to?(:each_pair)
#                  locator.each_pair do |link_text, url|
#                    session.should rspec_world.have_link(link_text, :href => url)
#                  end
#                else
#                  one_or_all(locator).each { |text| session.should rspec_world.have_link(text) }
#                end
#              when :ordered
#                #! we should extend this beyond simply text match (allow to pass full xpath)
#                nodes = session.all(:xpath, locator.collect { |n| "//node()[text()= \"#{n}\"]" }.join(' | '))
#                nodes.map(&:text).should == locator
#              else
#                raise("User can not see #{value} - you need to teach him how")
#            end
#          when 'Fixnum'
#            session.should ::Capybara::RSpecMatchers::HaveMatcher.new(*(get_selector(locator) << {:count => value}))
#          else
#            session.should rspec_world.have_field(locator, :with => value)
#        end
#      end
#    else
#      raise "Not Implemented Structure #{options} :: #{options.class}"
#  end
#end