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
              when Symbol
                prepare_actions(value => identifier.to_s)
              else
                case value
                  when Fixnum, Float, String
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
            case id
              when Symbol
                parse_params(option => id.to_s)
              when String
                if option.kind_of?(Array)
                  option.each do |o|
                    parse_params(o => id)
                  end
                else
                  actions << Action.new(action, option.to_s, :from => id)
                end
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

#! in future should we check in RackTest - does field is editable (detect readonly, disabled attributes) ?