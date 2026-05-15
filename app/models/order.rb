class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_one :financial_entry, dependent: :nullify

  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: :all_blank

  enum status: { draft: 0, confirmed: 1, canceled: 2 }

  validates :ordered_on, presence: true
  validate :must_have_items, unless: :draft?

  before_validation :set_ordered_on
  before_save :calculate_total
  after_save :sync_stock_and_finance, if: :saved_change_to_status?

  def recalculate_total!
    calculate_total
    save!
  end

  private

  def set_ordered_on
    self.ordered_on ||= Date.current
  end

  def calculate_total
    self.total = order_items.reject(&:marked_for_destruction?).sum(&:calculate_subtotal)
  end

  def must_have_items
    errors.add(:base, "adicione ao menos um item ao pedido") if order_items.reject(&:marked_for_destruction?).empty?
  end

  def sync_stock_and_finance
    return unless confirmed?

    order_items.each do |item|
      StockMovement.find_or_create_by!(
        product: item.product,
        kind: :exit,
        quantity: -item.quantity,
        description: "Saida do pedido ##{id}"
      )
    end

    FinancialEntry.find_or_create_by!(order: self) do |entry|
      entry.description = "Recebimento pedido ##{id}"
      entry.kind = :receivable
      entry.status = :open
      entry.amount = total
      entry.due_on = ordered_on + 7.days
    end
  end
end
