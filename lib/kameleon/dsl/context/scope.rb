module Kameleon
  module DSL
    module Context
      class Scope

        attr_accessor :params

        def initialize(params)
          @params = params
        end

        def selector
          detect_selector(params)
        end

        private

        def detect_selector(param)
          case param
            when Hash
              #! add warning when there is more then one element in hash
              Kameleon::DSL::Context::SpecialSelectors.send(*param.first)
            when Symbol
              normalize(defined_areas[param])
            when String
              normalize(param)
            when Array
              param.size == 1 ?
                  detect_selector(param.first) :
                  normalize(param)
            when nil
              normalize(default_selector)
            else
              raise "type <#{param.class.name}> not implemented"
          end
        end

        def normalize(params)
          case params
            when String
              [::Capybara.default_selector, params]
            when Array
              if params.empty?
                normalize(default_selector)
              elsif params.size == 1
                [::Capybara.default_selector] + params
              else
                params
              end
          end
        end

        def default_selector
          defined_areas[:default] || [:xpath, "//body"]
        end

        def defined_areas
          ::Kameleon::Session.defined_areas
        end
      end

      #! extending selectors in capybara way https://github.com/jnicklas/capybara/blob/master/lib/capybara.rb#L76
      module SpecialSelectors
        def self.row(param)
          case param
            when String
              [:xpath, "//tr[*='#{param}'][1]"]
            when Fixnum
              [:xpath, "//tbody/tr[#{param}]"]
            else
              raise "not implemented"
          end
        end

        def self.cell(param)
          value_in_row, value_in_column = *param
          if value_in_row.is_a?(Fixnum) and value_in_column.is_a?(Fixnum)
            [:xpath, "//tbody/tr[#{value_in_row}]/td[#{value_in_column}]"]
          else
            #! on page there might be more then one table
            position = Capybara.current_session.all(:xpath, "//table//th").index { |n| n.text =~ /#{value_in_column}/ }
            [:xpath, "//tr[*='#{value_in_row}'][1]/td[#{position+1}]"]
          end
        end

        def self.column(param)
          raise "not implemented"
          #            position = session.all(:xpath, "//table//th").index { |n| n.text =~ /#{value}/ }
          #            return [:xpath, ".//table//th[#{position + 1}] | .//table//td[#{position + 1}]", :select_multiple]
        end
      end
    end
  end
end

