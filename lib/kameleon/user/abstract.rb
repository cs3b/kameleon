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

      def see(content)
        session.should rspec_world.have_content(content)
      end

      private

      def load_homepage?
        !options[:skip_page_autoload]
      end
    end
  end
end