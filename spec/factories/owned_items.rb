FactoryBot.define do
  factory :owned_item do
    quantity { 2 }
  end
  factory :second_owned_item, class: OwnedItem do
    quantity { 3 }
  end
  factory :third_owned_item, class: OwnedItem do
    quantity { 1 }
  end
end
