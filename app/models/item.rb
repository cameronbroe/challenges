class Item < ApplicationRecord
  validates_presence_of :description
  validates_numericality_of :price
end
