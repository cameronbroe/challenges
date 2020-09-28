module HomeHelper
  def flattened_sales_data
    sales_data = []
    CustomerOrder.all.each do |customer_order|
      sales_data << {
          "Customer Name": customer_order.customer.first_name + " " + customer_order.customer.last_name,
          "Item Description": customer_order.customer_order_items[0].item.description,
          "Item Price": customer_order.customer_order_items[0].item.price,
          "Quantity": customer_order.customer_order_items[0].quantity,
          "Merchant Name": customer_order.merchant.name,
          "Merchant Address": customer_order.merchant.address
      }
    end
    sales_data
  end
end
