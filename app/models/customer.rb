class Customer < ApplicationRecord
  has_many :customer_orders

  validates_presence_of :first_name
  validates_presence_of :last_name
end
