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
        session.instance_eval do
          def within(*args)
            new_scope = if args.size == 1 && Capybara::Node::Base === args.first
                          args.first
                        else
                          if args.last == :select_multiple
                            node = find(*args)
                            native = Nokogiri::HTML.parse(all(*args[0..-2]).map(&:native).map(&:to_s).join)
                            base = Capybara::RackTest::Node.new(driver, native)
                            ::Capybara::Node::Element.new(self,
                                                          base,
                                                          node.parent,
                                                          node.instance_variable_get(:@selector))
                          else
                            find(*args)
                          end
                        end
            begin
              scopes.push(new_scope)
              yield
            ensure
              scopes.pop
            end
          end
        end
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
        if (selector.is_a?(Array) && selector.size == 1)
          selector = selector.first
        end
        case selector.class.name
          when 'Hash'
            selector.each_pair do |key, value|
              case key
                when :row
                  return [:xpath, "//tr[*='#{value}'][1]"]
                when :column
                  position =
                      session.all(:xpath, "//table//th").index { |n| n.text =~ /#{value}/ }
                  return [:xpath, "//table//th[#{position + 1}] | //table//td[#{position + 1}]", :select_multiple]
                else
                  raise "not supported selectors"
              end
            end
          when 'Symbol'
            page_areas[selector].is_a?(Array) ?
                page_areas[selector] :
                [Capybara.default_selector, page_areas[selector]]
          when 'Array'
            selector
          else
            [Capybara.default_selector, selector]
        end
      end

      def default_selector
        page_areas[:main]
      end

      #! rails dependency
      def default_files_path
        Rails.path.join('spec')
      end

      def one_or_all(elements)
        elements.is_a?(Array) ? elements : [elements]
      end

    end
  end
end