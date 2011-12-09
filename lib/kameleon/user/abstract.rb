module Kameleon
  module User
    class Abstract
      attr_accessor :options
      attr_accessor :rspec_world
      attr_accessor :session

      include Kameleon::Session::Capybara
      include Kameleon::Dsl::See
      include Kameleon::Dsl::Act

      def initialize(rspec_world, options={})
        @rspec_world = rspec_world
        @driver_name = options.delete(:driver)
        @session_name = options.delete(:session_name)
        @options = options
        set_session
        session.visit('/') if load_homepage?
        yield if block_given?
        after_initialization
      end

      def visit(page)
        session.visit(page)
      end

      def will(&block)
        instance_eval(&block)
      end

      private

      def load_homepage?
        !options[:skip_page_autoload]
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
    end
  end
end