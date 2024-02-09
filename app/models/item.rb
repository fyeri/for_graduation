class Item < ApplicationRecord
  has_many :item_labels
  has_many :labels, through: :item_labels
  has_one :owned_item
  has_one :wanted_item

  accepts_nested_attributes_for :owned_item, allow_destroy: true
  accepts_nested_attributes_for :wanted_item, allow_destroy: true
end
