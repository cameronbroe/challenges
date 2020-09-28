class CustomerOrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer_order
end
