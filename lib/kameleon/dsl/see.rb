module Kameleon
  module Dsl
    module See
      def see(*content)
        options = extract_options(content)

        case options.class.name
          when 'String'
            session.should rspec_world.have_content(options)
          when 'Array'
            options.each do |content_part|
              see(content_part)
            end
          when 'Hash'
            options.each_pair do |value, locator|
              case value.class.name
                when 'Symbol'
                  case value
                    when :empty
                      one_or_all(locator).each do |selector|
                        session.should rspec_world.have_field(selector)
                        session.find_field(selector).value.to_s.should == ""
                      end
                    when :checked
                      one_or_all(locator).each do |selector|
                        session.should rspec_world.have_checked_field(selector)
                      end
                    when :unchecked
                      one_or_all(locator).each do |selector|
                        session.should rspec_world.have_unchecked_field(selector)
                      end
                    when :selected
                      locator.each_pair do |selected_value, selected_locator|
                        session.should rspec_world.have_select(selected_locator, :selected => selected_value)
                      end
                    when :unselected
                      locator.each_pair do |selected_value, selected_locator|
                        session.should rspec_world.have_no_select(selected_locator, :selected => selected_value)
                      end
                    when :link, :links
                      locator.each_pair do |link_text, url|
                        session.should rspec_world.have_link(link_text, :href => url)
                      end
                    when :image, :images
                      one_or_all(locator).each do |selector|
                        session.should rspec_world.have_xpath("//img[@alt=\"#{selector}\"] | //img[@src=\"#{selector}\"]")
                      end
                    when :ordered
                      nodes = session.all(:xpath, locator.collect { |n| "//node()[text()= \"#{n}\"]" }.join(' | '))
                      nodes.map(&:text).should == locator
                    else
                      raise("User can not see #{value} - you need to teach him how")
                  end
                when 'Fixnum'
                  session.should ::Capybara::RSpecMatchers::HaveMatcher.new(*get_selector(locator), :count => value)
                else
                  session.should rspec_world.have_field(locator, :with => value)
              end
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
    end
  end
end
