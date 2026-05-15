FactoryBot.define do
  factory :stock_movement do
    product
    kind { :entry }
    quantity { 10 }
    description { "Entrada de teste" }
  end
end
