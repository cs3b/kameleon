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
            when String, Fixnum
              param = param.to_s
              conditions << Condition.new(:have_content, param)
            when Symbol
              prepare_conditions(:element => param)
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
                  when String
                    if type == ""
                      prepare_conditions(:empty => values)
                    else
                      conditions.concat TextInput.new(type, values).conditions
                    end
                  when :checked, :unchecked, :check, :uncheck
                    conditions.concat CheckBoxInput.new(type, values).conditions
                  when :selected, :unselected, :select, :unselect
                    conditions.concat SelectInput.new(type, values).conditions
                  when :field, :fields
                    conditions.concat TextInput.new(nil, values).conditions
                  when :empty
                    conditions.concat EmptyInput.new(values).conditions
                  when :element
                    conditions.concat Element.new(values).conditions
                  else
                    raise Kameleon::NotImplementedException, "Not implemented #{param}"
                end
              end
            when Array
              param.each { |parameter| prepare_conditions(parameter) }
            else
              raise Kameleon::NotImplementedException, "Not implemented #{param}"
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

      #! below class  require some deep refactoring

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

      class Element
        attr_reader :conditions, :expression

        def initialize(expression)
          @expression = expression
          @conditions = [condition]
        end

        private

        def condition
          Condition.new(have_selector_method, selector_expression)
        end

        def have_selector_method
          "have_#{selector.first}".to_sym
        end

        def selector
          @selector ||= Kameleon::DSL::Context::Scope.new(expression).selector
        end

        def selector_expression
          selector.last
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
            texts.uniq.should == elements.uniq
          end
        end

        def prepare_xpath
          params.collect { |n| "//node()[text()= \"#{n}\"]" }.join(' | ')
        end
      end

      class TextInput
        attr_reader :conditions, :value

        def initialize(value, *params)
          @value = value
          @conditions = []
          parse_params(params)
        end

        private

        def parse_params(params)
          case params
            when Symbol
              parse_params(params.to_s)
            when String
              conditions <<
                  if value.nil? or value == ""
                    Condition.new(:have_field, params)
                  else
                    Condition.new(:have_field, params, :with => value)
                  end
            when Array
              params.each { |param| parse_params(param) }
            else
              raise "not supported"
          end
        end
      end


      class EmptyInput
        attr_reader :conditions

        def initialize(*params)
          @conditions = []
          parse_params(params)
        end

        private

        def parse_params(params)
          case params
            when Symbol
              parse_params(params.to_s)
            when String
              conditions << condition(params)
            when Array
              params.each { |param| parse_params(param) }
            else
              raise "not supported"
          end
        end

        def condition(params)
          Condition.new(nil, params) do |element|
            page.should have_field(element)
            find_field(element).value.should satisfy do |value|
              value == nil or value == ""
            end
          end
        end
      end

      class CheckBoxInput
        attr_reader :conditions, :value

        def initialize(value, *params)
          @value = value
          @conditions = []
          parse_params(params)
        end

        private

        def parse_params(params)
          case params
            when String
              conditions << Condition.new(matcher_method, params)
            when Array
              params.each { |param| parse_params(param) }
            else
              raise "not supported"
          end
        end

        def matcher_method
          case value
            when :checked, :check
              :have_checked_field
            when :unchecked, :uncheck
              :have_unchecked_field
            else
              raise "not supported"
          end
        end
      end

      class SelectInput
        attr_reader :conditions, :value

        def initialize(value, *params)
          @value = value
          @conditions = []
          parse_params(params)
        end

        private

        def parse_params(params)
          case params
            when Hash
              params.each_pair do |selected_value, identifier|
                case identifier
                  when Array
                    selected_value.each do |value|
                      parse_params(value => identifier)
                    end
                  when Symbol
                    parse_params(selected_value => identifier.to_s)
                  when String
                    value = case selected_value
                              when Symbol, Fixnum
                                selected_value.to_s
                              when String, Array
                                selected_value
                              else
                                raise "not supported"
                            end
                    conditions << Condition.new(matcher_method, identifier, :selected => value)
                  else
                    raise "not supported"
                end
              end
            when Array
              params.each { |param| parse_params(param) }
            else
              raise "not supported"
          end
        end


        def matcher_method
          case value
            when :selected, :select
              :have_select
            when :unselected, :unselect
              :have_no_select
            else
              raise "not supported"
          end
        end
      end

    end

  end
end

#! see :button, :buttons -> have_button(selector)
#! see field that is :disabled, :readonly
