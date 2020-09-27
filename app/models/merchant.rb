class Merchant < ApplicationRecord
  has_many :customer_orders

  validates_presence_of :name
  validates_presence_of :address
end
