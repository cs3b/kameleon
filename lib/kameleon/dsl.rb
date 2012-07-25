require 'kameleon/dsl/verify/presence'
require 'kameleon/dsl/verify/absence'

require 'kameleon/dsl/act/mouse'
require 'kameleon/dsl/act/form'

require 'kameleon/ext/capybara/session_pool'
require 'kameleon/session'

require 'kameleon/dsl/context/scope'

module Kameleon
  module DSL

    def see(*args)
      Kameleon::DSL::Verify::Presence.new(*args).tap do |presence|
        presence.conditions.each do |condition|
          if block = condition.block
            instance_exec(*condition.params, &block)
          else
            page.should send(condition.method, *condition.params)
          end
        end
      end
    end

    #! hmn - very similar to see
    def not_see(*args)
      Kameleon::DSL::Verify::Absence.new(*args).tap do |absence|
        absence.conditions.each do |condition|
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

    def create_sessions(*names)
      names.each { |n| create_session(n) }
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
        ScopeProxy.new(self, scope)
      end
    end

    def click(*args)
      Kameleon::DSL::Act::Mouse::Click.new(*args).tap do |click|
        click.actions.each do |action|
          if block = action.block
            instance_exec(*action.params, &block)
          else
            page.send(action.method, *action.params)
          end
        end
      end
    end

    def fill_in(args)
      Kameleon::DSL::Act::Form.new(args).tap do |form|
        form.actions.each do |action|
          if block = action.block
            instance_exec(*action.params, &block)
          else
            page.send(action.method, *action.params)
          end
        end
      end
    end

    def refresh_page
      visit current_url
    end

    private

    def parse_selector(scope)
      Kameleon::DSL::Context::Scope.new(scope)
    end


    class ScopeProxy < Struct.new(:world, :scope)

      Kameleon::DSL.instance_methods.each do |method|
        define_method method do |*args|
          world.within(scope) do
            world.send(method, *args)
          end
        end
      end

    end
  end
end
