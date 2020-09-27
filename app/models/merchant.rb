class Merchant < ApplicationRecord
  has_many :customer_orders
end
