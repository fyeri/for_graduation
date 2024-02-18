FactoryBot.define do
  factory :item do
    name { "aa" }
    character { "aa" }
    category { 1 }

    trait :second_item do
        name { "cc" }
        character { "cc" }
        category { 2 }
    end
    trait :third_item do
        name { "bb" }
        character { "bb" }
        category { 3 }
    end
  end
end
