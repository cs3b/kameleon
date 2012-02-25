require 'kameleon/dsl/verify/presence'
require 'kameleon/dsl/verify/absence'

require 'kameleon/ext/capybara/session_pool'
require 'kameleon/session'

require 'kameleon/dsl/context/scope'

module Kameleon
  module DSL
    def load_page(url = '/')
      visit(url)
    end

    def see(*args)
      Kameleon::DSL::Verify::Presence.new(*args).tap do |presence|
        presence.conditions.each do |condition|
          if condition.block
            instance_eval(condition.block)
          else
            page.should send(condition.method, *condition.params)
          end
        end
      end
    end

    #! hmn - very similar to see
    def unseeing(*args)
      Kameleon::DSL::Verify::Absence.new(*args).tap do |presence|
        presence.conditions.each do |condition|
          if condition.block
            instance_eval(condition.block)
          else
            page.should send(condition.method, *condition.params)
          end
        end
      end
    end

    def create_session(name = :default)
      Kameleon::Session.new(name).tap { |ks| act_as(ks.name) }
    end

    def act_as(name)
      if block_given?
        using_session(name) do
          yield
        end
      else
        Capybara.session_name = name
      end
      self
    end

    def within(*scope, &block)
      if block_given?
        super(*parse_selector(scope).selector)
      else
        #! we need proxy object to make it working
        throw 'not impelemented'
      end
    end

    private

    def parse_selector(scope)
      Kameleon::DSL::Context::Scope.new(scope)
    end
  end
end