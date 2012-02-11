#def default_path_for_file(file_name)
#  File.join(Kameleon.default_file_path, file_name)
#end

#def fill_in(locators)
#  fill(locators) if can_fill?(locators)
#end
#
#private
#
#def fill(locators)
#  locators.each_pair do |value, selector|
#    case value
#      when :check, :choose, :uncheck
#        one_or_all(selector).each do |locator|
#          session.send(value, locator)
#        end
#      when :select, :unselect
#        selector.each_pair do |select_value, select_locator|
#          one_or_all(select_locator).each do |locator|
#            session.send(value, select_value, :from => locator)
#          end
#        end
#      when :attach
#        selector.each_pair do |file_path, locator|
#          session.attach_file(locator, get_full_test_asset_path(file_path))
#        end
#      else
#        one_or_all(selector).each do |locator|
#          session.fill_in(locator, :with => value)
#        end
#    end
#  end
#end
#
#def can_fill?(locators)
#  locators.values.each do |loc|
#    selectors = loc.respond_to?(:values) ? loc.values : loc
#    one_or_all(selectors).each do |selector|
#      return false if unmodifiable?(selector)
#    end
#  end
#end
#
#def unmodifiable?(locator)
#  field = session.find_field(locator)
#  case session.driver
#    when Capybara::Selenium::Driver
#      # In driver field attributes - disabled and readonly may be:
#      # 1) string - false or true
#      # 2) nil value
#      return eval(field[:disabled].to_s) || eval(field[:readonly].to_s)
#    when Capybara::RackTest::Driver
#      # In rack field attributes - disabled and readonly may be:
#      # 1) nil value
#      # 2) string - disabled or readonly
#      return field[:disabled] || field[:readonly]
#  end
#end
#
#def get_full_test_asset_path(file_path)
#  if File.file?(file_path)
#    file_path
#  elsif File.file?(Helpers.default_path_for_file(file_path))
#    Helpers.default_path_for_file(file_path)
#  else
#    raise "Sorry but we didn't found that file in: #{file_path}, neither #{Helpers.default_path_for_file(file_path)}"
#  end
#end