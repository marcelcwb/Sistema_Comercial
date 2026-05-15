require "rails_helper"

RSpec.describe FinancialEntry, type: :model do
  it "exige data de pagamento quando o lancamento esta pago" do
    entry = build(:financial_entry, status: :paid, paid_on: nil)

    expect(entry).not_to be_valid
    expect(entry.errors[:paid_on]).to include("informe a data de pagamento")
  end

  it "marca o lancamento como pago na data atual" do
    entry = create(:financial_entry)

    entry.mark_as_paid!

    expect(entry).to be_paid
    expect(entry.paid_on).to eq(Date.current)
  end
end
