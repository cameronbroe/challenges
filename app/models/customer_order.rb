class CustomerOrder < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :customer_order_items

  validates_presence_of :customer_order_items
end
