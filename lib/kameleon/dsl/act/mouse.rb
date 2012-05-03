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
              when Symbol
                prepare_actions(:element => param)
              when Hash
                param.each_pair do |type, values|
                  case type
                    when :element
                      actions << Action.new(:block, values) do |element|
                        selector = Kameleon::DSL::Context::Scope.new(element).selector
                        find(*selector).click
                      end
                    when :image
                      # Looks like Rack Test doesn't propagate click event up - this is simply hack
                      # It's not perfect it would work only when a is parent of image (not one of ancestor)
                      prepend_text =  "/.." if ::Capybara.current_driver == :rack_test

                      prepare_actions(:element => [:xpath, ".//img[@alt=\"#{values}\"]#{prepend_text}"])
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

#! click and dismiss
#! click and accept