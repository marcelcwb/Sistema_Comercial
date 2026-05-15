FactoryBot.define do
  factory :user do
    name { "Usuario Teste" }
    sequence(:email) { |n| "usuario#{n}@sistema.test" }
    password { "senha123" }
    password_confirmation { "senha123" }
    role { :operational }

    trait :administrator do
      role { :administrator }
    end

    trait :sales do
      role { :sales }
    end

    trait :finance do
      role { :finance }
    end
  end
end
