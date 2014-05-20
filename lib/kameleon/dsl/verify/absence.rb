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
              raise Kameleon::NotImplementedException, "Not implemented #{param}" unless param.respond_to? :to_s
              conditions << Condition.new(:have_no_content, param.to_s)
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

        #! below class need some love - refactoring

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

#! not_see :button, :buttons ->  have_no_button(selector)