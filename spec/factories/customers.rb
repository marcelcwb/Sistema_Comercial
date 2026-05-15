FactoryBot.define do
  factory :customer do
    sequence(:name) { |n| "Cliente #{n}" }
    sequence(:document) { |n| "00000000000#{n}" }
    sequence(:email) { |n| "cliente#{n}@sistema.test" }
    phone { "(11) 4000-0000" }
    city { "Sao Paulo" }
    state { "SP" }
  end
end
