class Product < ApplicationRecord
  validates :name, presence: true
  validates :brand, presence: true
  validates :stock_count, presence: true
end
