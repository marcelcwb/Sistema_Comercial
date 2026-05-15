require "rails_helper"

RSpec.describe "Financeiro", type: :request do
  before do
    sign_in create(:user, :finance)
  end

  it "cria um lancamento financeiro" do
    expect do
      post financial_entries_path, params: {
        financial_entry: {
          description: "Aluguel",
          kind: "payable",
          status: "open",
          amount: 1500,
          due_on: Date.current + 5.days
        }
      }
    end.to change(FinancialEntry, :count).by(1)

    expect(response).to redirect_to(FinancialEntry.last)
    expect(FinancialEntry.last).to be_payable
  end
end
