class CreateCustomerOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_order_items do |t|
      t.references :item
      t.references :customer_order
      t.integer :quantity

      t.timestamps
    end
  end
end
