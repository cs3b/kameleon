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
        content.each do |content_part|
          session.should rspec_world.have_content(content_part)
        end
      end

      def not_see(*content)
        content.each do |content_part|
          session.should_not rspec_world.have_content(content_part)
        end
      end

      def will(&block)
        instance_eval(&block)
      end

      private

      def load_homepage?
        !options[:skip_page_autoload]
      end
    end
  end
end