module Kameleon
  class Session
    attr_accessor :capybara_session, :name

    def initialize(name)
      @name = name

      take_free_session
    end

    private

    def take_free_session
      @capybara_session = Kameleon::Ext::Capybara::SessionPool.session(Capybara.current_driver, name)
    end
  end
end
