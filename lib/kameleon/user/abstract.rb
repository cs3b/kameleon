module Kameleon
  module User
    class Abstract
      attr_accessor :rspec_world
      attr_accessor :session

      include Kameleon::Session::Capybara

    end
  end
end