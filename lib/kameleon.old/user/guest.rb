module Kameleon
  module User
    class Guest < Abstract
      def initialize(rspec_world, options={}, &block)
        super
        instance_eval(&block) if block_given?
      end
    end
  end
end