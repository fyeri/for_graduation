FactoryBot.define do
  factory :wanted_item do
    quantity { 2 }
  end
  factory :second_wanted_item, class: WantedItem do
    quantity { 4 }
  end
  factory :third_wanted_item, class: WantedItem do
    quantity { 5 }
  end
end
