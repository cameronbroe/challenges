class CustomerOrder < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :customer_order_items
  has_many :items, through: :customer_order_item
end
