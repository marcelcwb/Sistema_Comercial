FactoryBot.define do
  factory :financial_entry do
    description { "Conta de teste" }
    kind { :receivable }
    status { :open }
    amount { 100.0 }
    due_on { Date.current + 7.days }
  end
end
