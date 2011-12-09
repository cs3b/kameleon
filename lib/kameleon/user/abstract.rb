module Kameleon
  module User
    class Abstract
      attr_accessor :options
      attr_accessor :rspec_world
      attr_accessor :session

      include Kameleon::Session::Capybara

      def visit(page)
        session.visit(page)
      end

      def see(*content)
        options = extract_options(content)

        case options.class.name
          when 'String'
            session.should rspec_world.have_content(options)
          when 'Array'
            options.each do |content_part|
              session.should rspec_world.have_content(content_part)
            end
          when 'Hash'
            options.each_pair do |value, locator|
              session.should rspec_world.have_field(locator, :with => value)
            end
          else
            raise "Not Implemented Structure #{options} :: #{options.class}"
        end

      end

      def not_see(*content)
        options = extract_options(content)

        case options.class.name
          when 'String'
            session.should_not rspec_world.have_content(options)
          when 'Array'
            options.each do |content_part|
              session.should_not rspec_world.have_content(content_part)
            end
          when 'Hash'
            options.each_pair do |value, locator|
              session.should_not rspec_world.have_field(locator, :with => value)
            end
          else
            raise "Not Implemented Structure #{options} :: #{options.class}"
        end
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
    end
  end
end