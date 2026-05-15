FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Produto #{n}" }
    sequence(:sku) { |n| "SKU-#{n}" }
    price { 25.5 }
    minimum_stock { 5 }
  end
end
