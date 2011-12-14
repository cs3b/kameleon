module Kameleon
  module Dsl
    module Act

      def click(*links)
        links.each do |link|
          session.click_on(link)
        end
      end

      def fill_in(fields)
        fields.each_pair do |value, selector|
          case value
            when :check
              one_or_all(selector).each do |locator|
                session.check locator
              end
            when :choose
              one_or_all(selector).each do |locator|
                session.choose(locator)
              end
            when :uncheck
              one_or_all(selector).each do |locator|
                session.uncheck locator
              end
            when :select
              selector.each_pair do |value, select_locator|
                one_or_all(select_locator).each do |locator|
                  session.select value, :with => locator
                end
              end
            when :unselect
              selector.each_pair do |value, select_locator|
                one_or_all(select_locator).each do |locator|
                  session.unselect value, :with => locator
                end
              end
            else
              session.fill_in selector, :with => value
          end
        end
      end

#      def click(link_text, options={:within => DEFAULT_AREA})
#  yield if block_given?
#  rspec_world.within(options[:within]) do
#    begin
#      rspec_world.click_on(self_or_translation_for(link_text))
#    rescue Capybara::ElementNotFound => e
#      attr_value, attr_type = within_value_and_type(options[:within])
#      xpath = attr_type ? "//*[@#{attr_type}='#{attr_value}']//*[*='%s']/*" : "//*[#{attr_type}]//*[*='%s']/*"
#      rspec_world.find(:xpath, xpath % self_or_translation_for(link_text)).click
#    end
#  end
#end


    end
  end
end