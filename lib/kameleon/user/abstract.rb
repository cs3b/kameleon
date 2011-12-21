module Kameleon
  module User
    class Abstract
      attr_accessor :options
      attr_accessor :rspec_world

      include Kameleon::Session::Capybara
      include Kameleon::Dsl::See
      include Kameleon::Dsl::Act

      def initialize(rspec_world, options={})
        @rspec_world = rspec_world
        @driver_name = options.delete(:driver)
        @session_name = options.delete(:session_name)
        @options = options
        set_session
        yield if block_given?
        after_initialization
      end

      def visit(page)
        session.visit(page)
      end

      def will(&block)
        default_selector ?
            within(*default_selector, &block) :
            instance_eval(&block)
      end

      def within(*selector, &block)
        session.within(*get_selector(selector)) do
          instance_eval(&block)
        end
      end

      def page_areas
        {}
      end

      def debug
        session
      end

      private

      def load_homepage?
        !options[:skip_page_autoload]
      end

      def session
        @session
      end

      def extract_options(opts)
        if opts.size == 1
          opts.first
        else
          opts
        end
      end

      def after_initialization
        # stub, should be implemented in subclass
      end

      def get_selector(selector)
        case selector.class.name
          when 'Hash'
            selector.each_pair do |key, value|
              case key
                when :row
                  "//tr[*='#{value}'][1]"
                else
                  raise "not supported selectors"
              end
            end.join('')
          when 'Symbol'
            page_areas[selector]
          when 'Array'
            selector
          else
            [Capybara.default_selector, selector]
        end
      end

      def default_selector
        page_areas[:main]
      end

      def one_or_all(elements)
        elements.is_a?(Array) ? elements : [elements]
      end
    end
  end
end