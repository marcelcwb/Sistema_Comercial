class StockMovement < ApplicationRecord
  belongs_to :product

  enum kind: { entry: 0, exit: 1, adjustment: 2 }

  validates :kind, :quantity, presence: true
  validates :quantity, numericality: { other_than: 0, only_integer: true }
  validate :entry_quantity_is_positive
  validate :exit_quantity_is_negative

  private

  def entry_quantity_is_positive
    errors.add(:quantity, "deve ser positiva para entradas") if entry? && quantity.to_i <= 0
  end

  def exit_quantity_is_negative
    errors.add(:quantity, "deve ser negativa para saidas") if exit? && quantity.to_i >= 0
  end
end
