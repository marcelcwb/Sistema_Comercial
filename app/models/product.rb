class Product < ApplicationRecord
  has_many :stock_movements, dependent: :destroy
  has_many :order_items, dependent: :restrict_with_error

  validates :name, :sku, presence: true
  validates :sku, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :minimum_stock, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def stock_balance
    stock_movements.sum(:quantity)
  end

  def low_stock?
    stock_balance <= minimum_stock
  end
end
