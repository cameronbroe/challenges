require 'rails_helper'

RSpec.describe SalesData do
  context "there is no reused data" do
    it "should parse the sales CSV and create new objects" do
      sales_csv = <<-DATA.strip_heredoc
      Customer Name,Item Description,Item Price,Quantity,Merchant Name,Merchant Address
      Jack Burton,Premium Cowboy Boots,149.99,1,Carpenter Outfitters,99 Factory Drive
      DATA

      SalesData.handle(sales_csv)

      expect(Customer.count).to be(1)
      expect(Item.count).to be(1)
      expect(Merchant.count).to be(1)
      expect(CustomerOrder.count).to be(1)
      expect(CustomerOrderItem.count).to be(1)
    end
  end

  context "there is reused data" do
    it "should parse the sales CSV and reuse a customer" do
      sales_csv = <<-DATA.strip_heredoc
      Customer Name,Item Description,Item Price,Quantity,Merchant Name,Merchant Address
      Ellen Ripley,Tank Top Undershirt,9.50,2,Hero Outlet,123 Main Street
      Ellen Ripley,Stomper Shoes,129.00,1,Parker Footwear,77 Main Street
      DATA

      SalesData.handle(sales_csv)

      expect(Customer.count).to be(1)
      expect(Item.count).to be(2)
      expect(Merchant.count).to be(2)
      expect(CustomerOrder.count).to be(2)
      expect(CustomerOrderItem.count).to be(2)
    end

    it "should parse the sales CSV and reuse a merchant" do
      sales_csv = <<-DATA.strip_heredoc
      Customer Name,Item Description,Item Price,Quantity,Merchant Name,Merchant Address
      Ellen Ripley,Tank Top Undershirt,9.50,2,Hero Outlet,123 Main Street
      Butch Coolidge,Black Hoodie,49.99,3,Hero Outlet,123 Main Street
      DATA

      SalesData.handle(sales_csv)

      expect(Customer.count).to be(2)
      expect(Item.count).to be(2)
      expect(Merchant.count).to be(1)
      expect(CustomerOrder.count).to be(2)
      expect(CustomerOrderItem.count).to be(2)
    end

    it "should parse the sales CSV and reuse an item" do
      sales_csv = <<-DATA.strip_heredoc
      Customer Name,Item Description,Item Price,Quantity,Merchant Name,Merchant Address
      Butch Coolidge,Black Hoodie,49.99,3,Hero Outlet,123 Main Street
      Ellen Ripley,Black Hoodie,49.99,1,Parker Footwear,77 Main Street
      DATA

      SalesData.handle(sales_csv)

      expect(Customer.count).to be(2)
      expect(Item.count).to be(1)
      expect(Merchant.count).to be(2)
      expect(CustomerOrder.count).to be(2)
      expect(CustomerOrderItem.count).to be(2)
    end
  end
end