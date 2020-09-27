class CreateCustomerOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_orders do |t|
      t.references :customer
      t.references :merchant

      t.timestamps
    end
  end
end
