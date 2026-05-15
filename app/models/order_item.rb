class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0, only_integer: true }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_unit_price
  before_save :calculate_subtotal

  def calculate_subtotal
    self.subtotal = quantity.to_i * unit_price.to_d
  end

  private

  def set_unit_price
    self.unit_price ||= product&.price
  end
end
