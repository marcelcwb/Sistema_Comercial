FactoryBot.define do
  factory :order do
    customer
    status { :draft }
    ordered_on { Date.current }

    trait :with_item do
      after(:build) do |order|
        order.order_items << build(:order_item, order: order)
      end
    end
  end
end
