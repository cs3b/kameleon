module Kameleon
  module Dsl
    module Act

      def click(*links)
        links.each do |link|
          session.click_on(link)
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