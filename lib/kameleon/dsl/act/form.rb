module Kameleon
  module DSL
    module Act
      class Form
        attr_reader :params
        attr_reader :actions

        def initialize(params)
          raise "not supported" unless params.kind_of?(Hash)
          @params = params
          @actions = []
          parse_actions
        end

        private

        def parse_actions
          prepare_actions(params)
        end

        def prepare_actions(param)
          param.each_pair do |value, identifier|
            case identifier
              when Array
                identifier.each { |identifier| prepare_actions(value => identifier) }
              else
                case value
                  when Fixnum, String
                    actions << Action.new(:fill_in, identifier, :with => value)
                  when :check, :choose, :uncheck
                    actions << Action.new(value, identifier)
                  when :select, :unselect
                    actions.concat SelectTag.new(value, identifier).actions
                  when :attach
                    actions.concat AttachFileTag.new(identifier).actions
                  else
                    raise "not implemented"
                end
            end
          end
        end
      end

      class SelectTag
        attr_reader :actions, :action

        def initialize(action, params)
          raise "not implemented" unless params.kind_of?(Hash)
          @action = action
          @actions = []
          parse_params(params)
        end

        def parse_params(params)
          params.each_pair do |option, id|
            if option.kind_of?(Array)
              option.each do |o|
                parse_params(o => id)
              end
            else
              actions << Action.new(action, option, :from => id)
            end
          end
        end
      end

      class AttachFileTag
        attr_reader :actions

        def initialize(params)
          raise "not implemented" unless params.kind_of?(Hash)
          @actions = []
          parse_params(params)
        end

        private

        def parse_params(params)
          params.each_pair do |filename, identifier|
            if identifier.kind_of?(Array)
              identifier.each do |id|
                parse_params(filename => id)
              end
            else
              actions << Action.new(:attach_file, identifier, full_path(filename))
            end
          end
        end

        def full_path(filename)
          if File.file?(filename)
            filename
          else
            prepare_full_path(filename)
          end
        end

        def prepare_full_path(filename)
          File.join(Kameleon::Utils::Configuration.assets_dir, filename)
        end
      end
    end
  end
end

#def can_fill?(locators)
#  locators.values.each do |loc|
#    selectors = loc.respond_to?(:values) ? loc.values : loc
#    one_or_all(selectors).each do |selector|
#      return false if unmodifiable?(selector)
#    end
#  end
#end
#
#def unmodifiable?(locator)
#  field = session.find_field(locator)
#  case session.driver
#    when Capybara::Selenium::Driver
#      # In driver field attributes - disabled and readonly may be:
#      # 1) string - false or true
#      # 2) nil value
#      return eval(field[:disabled].to_s) || eval(field[:readonly].to_s)
#    when Capybara::RackTest::Driver
#      # In rack field attributes - disabled and readonly may be:
#      # 1) nil value
#      # 2) string - disabled or readonly
#      return field[:disabled] || field[:readonly]
#  end
#end
#
#def get_full_test_asset_path(file_path)
#  if File.file?(file_path)
#    file_path
#  elsif File.file?(Helpers.default_path_for_file(file_path))
#    Helpers.default_path_for_file(file_path)
#  else
#    raise "Sorry but we didn't found that file in: #{file_path}, neither #{Helpers.default_path_for_file(file_path)}"
#  end
#end