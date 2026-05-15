class FinancialEntry < ApplicationRecord
  belongs_to :order, optional: true

  enum :kind, { receivable: 0, payable: 1 }
  enum :status, { open: 0, paid: 1, overdue: 2, canceled: 3 }

  validates :description, :kind, :status, :amount, :due_on, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validate :paid_entries_need_paid_on

  scope :due_until_today, -> { where(due_on: ..Date.current) }

  def mark_as_paid!
    update!(status: :paid, paid_on: Date.current)
  end

  private

  def paid_entries_need_paid_on
    errors.add(:paid_on, "informe a data de pagamento") if paid? && paid_on.blank?
  end
end
