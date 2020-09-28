class CustomerOrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer_order

  validates_numericality_of :quantity
end
