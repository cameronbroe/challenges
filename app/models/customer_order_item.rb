class CustomerOrderItem < ApplicationRecord
  has_one :item
  has_one :customer_order
end
