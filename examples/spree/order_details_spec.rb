#https://github.com/spree/spree/blob/master/core/spec/requests/admin/orders/order_details_spec.rb

require 'spec_helper'

feature "Order Details", :driver => :selenium do
  context "edit order page" do
    it "should allow me to edit order details", :js => true do
      reset_spree_preferences do |config|
        config.allow_backorders = true
      end

      order = Factory(:order, :completed_at => "2011-02-01 12:36:15", :number => "R100")
      product = Factory(:product, :name => 'spree t-shirt', :on_hand => 5)
      order.add_variant(product.master, 2)
      order.inventory_units.each do |iu|
        iu.update_attribute_without_callbacks('state', 'sold')
      end

      @admin = TestUserAdministrator.new(self)

      @admin.click "Orders"

      @admin.within('table#listing_orders tbody tr:nth-child(1)') { click "R100" }
      @admin.see "spree t-shirt", "$39.98"
      @admin.click "Edit"
      @admin.fill_in("1" => "order_line_items_attributes_0_quantity")
      @admin.see "Total: $19.99"
    end
  end
end
