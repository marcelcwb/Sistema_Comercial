FactoryBot.define do
  factory :order_item do
    order
    product
    quantity { 2 }
    unit_price { 15.0 }
  end
end
