require 'csv'

class SalesData
  def self.handle(sales_csv)
    parsed_csv = CSV.new(sales_csv, headers: true)
    parsed_csv.each do |row|
      first_name, last_name = row["Customer Name"].split(' ')
      customer_entry = Customer.find_or_create_by(
          first_name: first_name,
          last_name: last_name
      )

      item_entry = Item.find_or_create_by(
          description: row["Item Description"],
          price: row["Item Price"].to_f
      )

      merchant_entry = Merchant.find_or_create_by(
          name: row["Merchant Name"],
          address: row["Merchant Address"]
      )

      CustomerOrder.create(
          customer: customer_entry,
          merchant: merchant_entry,
          customer_order_items: [
              CustomerOrderItem.create(
                  item: item_entry,
                  quantity: row["Quantity"].to_i
              )
          ]
      )
    end
  end

  def self.validate(sales_csv)
    parsed_csv = CSV.new(sales_csv, headers: true)
    parsed_csv.each do |row|
      required_columns = [
          "Customer Name",
          "Item Description",
          "Item Price",
          "Quantity",
          "Merchant Name",
          "Merchant Address"
      ]
      required_columns.each do |column|
        return false unless row.include?(column) && !row[column].empty?
      end
    end
    return true
  end
end