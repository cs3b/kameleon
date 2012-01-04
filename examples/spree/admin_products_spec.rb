#https://github.com/spree/spree/blob/master/core/spec/requests/admin/products/products_spec.rb

require 'spec_helper'

feature "Products", :driver => :selenium do
  background do
    @admin = TestUserAdministrator.new(self) do
      visit spree.admin_path
    end
  end

  context "listing products" do
    it "should list existing products with correct sorting" do
      Factory(:product, :name => 'apache baseball cap', :available_on => '2011-01-06 18:21:13:', :count_on_hand => '0')
      Factory(:product, :name => 'zomg shirt', :available_on => '2125-01-06 18:21:13', :count_on_hand => '5')

      @admin.click "Products"
      @admin.see :ordered => ["apache baseball cap", "zomg shirt" ]
      @admin.click "admin_products_listing_name_title"
      @admin.see :ordered =>  ["zomg shirt", "apache baseball cap"  ]

    end
  end

  context "searching products" do
    it "should be able to search deleted products", :js => true do
      Factory(:product, :name => 'apache baseball cap', :available_on => '2011-01-06 18:21:13:', :deleted_at => "2011-01-06 18:21:13")
      Factory(:product, :name => 'zomg shirt', :available_on => '2125-01-06 18:21:13')

      @admin.click "Products"
      @admin.see "zomg shirt"
      @admin.not_see "apache baseball cap"

      @admin.fill_in(:check => "Show Deleted")
      @admin.click "Search"
      @admin.see "zomg shirt" , "apache baseball cap"

      @admin.fill_in(:uncheck => "Show Deleted")
      @admin.click "Search"

      @admin.see "zomg shirt"
      @admin.not_see "apache baseball cap"
    end

    it "should be able to search products by their properties" do
      Factory(:product, :name => 'apache baseball cap', :available_on => '2011-01-01 01:01:01', :sku => "A100")
      Factory(:product, :name => 'apache baseball cap2', :available_on => '2011-01-01 01:01:01', :sku => "B100")
      Factory(:product, :name => 'zomg shirt', :available_on => '2011-01-01 01:01:01', :sku => "Z100")
      Spree::Product.update_all :count_on_hand => 10

      @admin.click "Products"
      @admin.fill_in( "ap" => "search_name_contains")

      @admin.click "Search"
      @admin.see "apache baseball cap", "apache baseball cap2"
      @admin.not_see "zomg shirt"

      @admin.fill_in( "A1" => "search_variants_including_master_sku_contains")
      @admin.click "Search"

      @admin.see  "apache baseball cap"
      @admin.not_see "apache baseball cap2", "zomg shirt"

    end
  end

  context "creating a new product" do

    background do
     @admin.click  "Products", "admin_new_product"
     @admin.within('#new_product') { see "SKU" }
    end

    it "should allow an admin to create a new product", :js => true do
      @admin.fill_in("Baseball Cap" => "product_name" )
      @admin.fill_in("B100" => "product_sku" )
      @admin.fill_in("100" => "product_price" )
      @admin.fill_in("2012/01/24" => "product_available_on" )

      @admin.click "Create"

      @admin.see "successfully created!"
      @admin.fill_in("100" => "product_on_hand")

      @admin.click "Update"
      @admin.see "successfully updated!"
    end

    it "should show validation errors", :js => true do
      @admin.click "Create"
      @admin.see "Name can't be blank", "Price can't be blank"
    end
  end

  context "cloning a product" do
    it "should allow an admin to clone a product" do
      Factory(:product, :name => 'apache baseball cap', :available_on => '2011-01-01 01:01:01', :sku => "A100")

      @admin.click  "Products"

      @admin.within('table#listing_products tr:nth-child(2)') { click "Clone" }
      @admin.see "Product has been cloned"
    end
  end

  context "uploading a product image" do
    it "should allow an admin to upload an image and edit it for a product" do
      Factory(:product, :name => 'apache baseball cap', :available_on => '2011-01-01 01:01:01', :sku => "A100")
      Factory(:product, :name => 'apache baseball cap2', :available_on => '2011-01-01 01:01:01', :sku => "B100")
      Factory(:product, :name => 'zomg shirt', :available_on => '2011-01-01 01:01:01', :sku => "Z100")
      Spree::Product.update_all :count_on_hand => 10

      @admin.click "Products"
      @admin.within('table#listing_products tr:nth-child(2)') { click "Edit" }
      @admin.click  "Images", "new_image_link"

      absolute_path = File.expand_path(Rails.root.join('..', '..', 'spec', 'support', 'ror_ringer.jpeg'))
      @admin.fill_in(:attach => ['image_attachment', absolute_path] )

      @admin.click "Update"
      @admin.see "successfully created!"

      @admin.within('table.index tr:nth-child(2)') { click  "Edit" }
      @admin.fill_in("ruby on rails t-shirt" => "image_alt")

      @admin.click "Update"

      @admin.see "successfully updated!", "ruby on rails t-shirt"
    end
  end
end
