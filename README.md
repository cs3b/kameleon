# Kameleon [chameleon]

[!https://secure.travis-ci.org/cs3b/kameleon.png?branch=master](http://travis-ci.org/cs3b/kameleon)

Kameleon is a high abstraction dsl for better writing acceptance and integrationtests using Capybara.
And "better" means: more easily to mimic how user interact with browser.

## Setup

Kameleon requires:

* rspec
* capybara

Optionally is nice to use:

* selenium-wedriver && capybara-webkit for testing together with javascript
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

### Example One [listing products > should list existing products with correct sorting ]

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


### Example Two [should allow an admin to create a new product and variants from a prototype]

kameleon

``` ruby
click "Products",
      "admin_new_product"
fill_in "Baseball Cap" => "product_name",
        "B100" => "product_sku",
        "100" => "product_price",
        "2012/01/24" => "product_available_on",
        :select => { "Size" => "Prototype" },
        :check => "Large"
click "Create"
see "successfully created!"
```

vs capybara

``` ruby
click_link "Products"
click_link "admin_new_product"
fill_in "product_name", :with => "Baseball Cap"
fill_in "product_sku", :with => "B100"
fill_in "product_price", :with => "100"
fill_in "product_available_on", :with => "2012/01/24"
select "Size", :from => "Prototype"
check "Large"
click_button "Create"
page.should have_content("successfully created!")

```

taken from: https://github.com/spree/spree/blob/master/core/spec/requests/admin/products/products_spec.rb#L77


### Example Three [admin editing an adjustment > successfully > should update the adjustment]

kameleon

``` ruby
within(:row => 2) { click "Edit" }
fill_in 99 => "adjustment_amount",
        "rebate 99" => "adjustment_label"
click "Continue"
see "successfully updated!",
    "rebate 99",
    "$99.00"
```

vs capybara

``` ruby
within(:css, 'table.index tr:nth-child(2)') { click_link "Edit" }
fill_in "adjustment_amount", :with => "99"
fill_in "adjustment_label", :with => "rebate 99"
click_button "Continue"
page.should have_content("successfully updated!")
page.should have_content("rebate 99")
page.should have_content("$99.00")

```

taken from: https://github.com/spree/spree/blob/master/core/spec/requests/admin/orders/adjustments_spec.rb#L48

### Example Four [payment method > should be able to list, edit, and create payment methods for an order]

kameleon

``` ruby
click "Orders"
within('table#listing_orders', :row => 1) { click_link "R100" }
click "Payments"
within('#payment_status') { see "Payment: balance due" }
within(:cell => [2, 2]) { see "$39.98" }
within(:cell => [2, 3]) { see "Credit Card" }
within(:cell => [2, 4]) { see "pending" }
```
vs capybara

``` ruby
visit spree.admin_path
click_link "Orders"
within('table#listing_orders tbody tr:nth-child(1)') { click_link "R100" }
click_link "Payments"
within('#payment_status') { page.should have_content("Payment: balance due") }
find('table.index tbody tr:nth-child(2) td:nth-child(2)').text.should == "$39.98"
find('table.index tbody tr:nth-child(2) td:nth-child(3)').text.should == "Credit Card"
find('table.index tbody tr:nth-child(2) td:nth-child(4)').text.should == "pending"
```
kameleon

``` ruby
click "Void"
within('#payment_status') { see "Payment: balance due" }
see "Payment Updated"
within(:cell => [2,2] { see "$39.98" }
within(:cell => [2,3] { see "Credit Card" }
within(:cell => [2,4] { see "void" }
```

vs capybara

``` ruby
click_button "Void"
within('#payment_status') { page.should have_content("Payment: balance due") }
page.should have_content("Payment Updated")
find('table.index tbody tr:nth-child(2) td:nth-child(2)').text.should == "$39.98"
find('table.index tbody tr:nth-child(2) td:nth-child(3)').text.should == "Credit Card"
find('table.index tbody tr:nth-child(2) td:nth-child(4)').text.should == "void"
```
kameleon

``` ruby
click "New Payment"
see "New Payment"
click "Continue",
      "Capture"
within('#payment_status') { see "Payment: paid" }
see :element => '#new_payment_section'

click "Shipments",
      "New Shipment"
within('table.index', :row => 2) { check "#inventory_unit" }

click "Create"
see "successfully created!"
```
vs capybara

``` ruby
click_on "New Payment"
page.should have_content("New Payment")
click_button "Continue"
click_button "Capture"
within('#payment_status') { page.should have_content("Payment: paid") }
page.should_not have_css('#new_payment_section')

click_link "Shipments"
click_on "New Shipment"
within('table.index tbody tr:nth-child(2)') { check "#inventory_unit" }
click_button "Create"
page.should have_content("successfully created!")
```

taken from: https://github.com/spree/spree/blob/master/core/spec/requests/admin/orders/payments_spec.rb#L32


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

## Credits
* [Michał Czyż](http://selleo.com/people/michal-czyz)
* [Radosław Jędryszczak](http://selleo.com/people/radoslaw-jedryszczak)
* [Szymon Kieloch](http://selleo.com/people)
