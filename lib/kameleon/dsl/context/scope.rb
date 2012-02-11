#session.instance_eval do
#  def within(*args)
#    new_scope = if args.size == 1 && Capybara::Node::Base === args.first
#                  args.first
#                elsif args.last == :select_multiple
#                  case driver
#                    when Capybara::Selenium::Driver
#                      raise "So far Unsupported in this driver"
#                    when Capybara::RackTest::Driver
#                      node = find(*args)
#                      native = Nokogiri::HTML.parse(html).xpath(args[1])
#                      base = Capybara::RackTest::Node.new(driver, native)
#                      ::Capybara::Node::Element.new(self,
#                                                    base,
#                                                    node.parent,
#                                                    node.instance_variable_get(:@selector))
#                  end
#                else
#                  find(*args)
#                end
#    begin
#      scopes.push(*new_scope)
#      yield
#    ensure
#      scopes.pop
#    end
#  end
#end

#def within(*selector, &block)
#  session.within(*get_selector(selector)) do
#    instance_eval(&block)
#  end
#end

#def get_selector(selector)
#  if (selector.is_a?(Array) && selector.size == 1)
#    selector = selector.first
#  end
#  case selector
#    when Hash
#      selector.each_pair do |key, value|
#        case key
#          when :row
#            return [:xpath, "//tr[*='#{value}'][1]"]
#          when :column
#            position = session.all(:xpath, "//table//th").index { |n| n.text =~ /#{value}/ }
#            return [:xpath, ".//table//th[#{position + 1}] | .//table//td[#{position + 1}]", :select_multiple]
#          else
#            raise "not supported selectors"
#        end
#      end
#    when Symbol
#      page_areas[selector].is_a?(Array) ?
#          page_areas[selector] :
#          [Capybara.default_selector, page_areas[selector]]
#    when Array
#      selector
#    else
#      [Capybara.default_selector, selector]
#  end
#end

#def default_selector
#  page_areas[:main]
#end
#def page_areas
#  {}
#end
