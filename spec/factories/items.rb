FactoryBot.define do
  factory :item do
    name { "aa" }
    character { "aa" }
    category { 1 }
    purchased_on { "2024-02-01" }
  end

  factory :second_item, class: Item do
      name { "bb" }
      character { "bb" }
      category { 1 }
      purchased_on { "2024-02-05" }
  end

  factory :third_item, class: Item do
      name { "cc" }
      character { "cc" }
      category { 3 }
      purchased_on { "2024-02-08" }
  end
  factory :fourth_item, class: Item do
    name { "ee" }
    character { "ee" }
    category { 1 }
    purchased_on { "2024-02-09" }
  end
end

