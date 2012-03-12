# Kameleon [chameleon]

![Travis](https://secure.travis-ci.org/cs3b/kameleon.png?branch=master "http://travis-ci.org/cs3b/kameleon")

Kameleon is a high abstraction dsl for better writing acceptance and integrationtests using Capybara.
And "better" means: more easily to mimic how user interact with browser.

## Setup

Kameleon requires:

* rspec
* capybara

Optionally is nice to use:

* devise (Kameleon uses paths suplied by devise. So if you're using some other authentication solution, you might want to overwrite it)
* selenium-wedriver && capybara-webkit for testing full site
* thin (if you want run your specs faster - add gem 'thin' to Gemfile in your app)

Gemfile

    gem 'kameleon', '>= 0.2.0.aplha.2'

Before you start using Kameleon ensure that capybara is properly loaded (in your test helper file)

    require 'kameleon/ext/rspec/all'

or just components you want; `kemeleon/ext/rspec/all` by default loads:

    require 'kameleon/ext/rspec/dsl'
    require 'kameleon/ext/rspec/garbage_collector'
    require 'kameleon/ext/rspec/headless'

## Usage

checkout this [slides from wrocloverb 2012](http://www.slideshare.net/cs3b/2012wrocloverbuserperspectivetestingusingruby)

### Examples

kameleon

``` ruby
  click "Products"
  within('table.index) do
    see :ordered => [ "apache baseball cap",
                      "zomg shirt" ]
  end
  click "admin_products_listing_name_title"
  within('table.index') do
    see :ordered => [ "zomg shirt",
                      "apache baseball cap"]
  end

```

vs capybara

``` ruby
  click_link "Products"
  within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
  within('table.index tr:nth-child(3)') { page.should have_content("zomg shirt") }
  click_link "admin_products_listing_name_title"
  within('table.index tr:nth-child(2)') { page.should have_content("zomg shirt") }
  within('table.index tr:nth-child(3)') { page.should have_content("apache baseball cap") }
```

taken from: https://github.com/spree/spree/blob/master/core/spec/requests/admin/products/products_spec.rb#L22

Another example:

    feature "Products", :driver => :selenium do
      background do
        @admin = Factory.create(:user)
        create_session(:admin)
        visit spree.admin_path
      end

      context "listing products" do
        scenario "products sorting" do
          Factory(:product, :name => 'apache baseball cap',
                            :available_on => '2011-01-06 18:21:13:',
                            :count_on_hand => '0')
          Factory(:product, :name => 'zomg shirt',
                            :available_on => '2125-01-06 18:21:13',
                            :count_on_hand => '5')

          act_as(:admin) do
            click "Products"
            see :ordered => ["apache baseball cap", "zomg shirt"]

            click "admin_products_listing_name_title"
            see :ordered => ["zomg shirt", "apache baseball cap"]
          end
        end
      end
    end

And more complex example, with two user sessions:

    scenario "admin adds a product and user buys it", :status => "done", :driver => :selenium do
      create_session(:admin)
      @admin = Factory.create(:admin_user)
      create_session(:user)

      act_as(:admin) do
        visit spree.admin_path
        click "Products", "admin_new_product"
        within('#new_product') do
          see "SKU"
        end
        fill_in "product_name" => "Baseball Cap",
                "product_sku" => "B100",
                "product_price"=> "100",
                "product_available_on"=> "2012/01/24"

        click "Create"
        see "successfully created!"

        fill_in "product_on_hand" => "100"
        click "Update"
        see "successfully updated!"
      end

      act_as(:user) do
        visit spree.root_path
        click "Baseball Cap", "add-to-cart-button", "Checkout"
        within("span.out-of-stock") do
          see "Baseball Cap added to your cart"
        end
      end
    end


## Tips & Tricks

* You have access to page variable. So if you think that something cannot be accomplished by the Kameleon DSL, you can just write using RSpec matchers and page variable. Like this: `page.should have_css("li.banner_message", :count => 10)`. Of course, after you've submitted feature request to the owner of the original repository ;)
* It is handy to define a common set of areas, that user often follows navigating on the site. Here is an example

    ```
    Kameleon::Session.defined_areas.merge!({:menu => [:xpath, "//nav/ul"],
                                              :main => '.main_body',
                                              :right_column => '.col_aside',
                                              :ordered_list => '.ordered_list',
                                              :favourites => '.favourites_list',
                                              :gallery_tiny => '.gallery_tiny',
                                              :gallery_list => '.gallery_list',
                                              :content => '.col_content',
                                              :col_aside => '.col_aside'})`
    ```


### Session pooling
Soon we will merge with new capybara approach for that

Kameleon has useful technique of session pooling implemented, that can speed up test suite greatly.
In order to enable it, you need to pass this to the RSpec.configure block, in spec_helper.rb:

    config.after(:each) do
      ::SessionPool.release_all
    end

## Credits
* [Michał Czyż](http://selleo.com/people/michal-czyz)
* [Radosław Jędryszczak](http://selleo.com/people/radoslaw-jedryszczak)
* [Szymon Kieloch](http://selleo.com/people)
