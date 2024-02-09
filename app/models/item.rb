class Item < ApplicationRecord
  has_many :item_labels
  has_many :labels, through: :item_labels
  has_one :owned_item
  has_one :wanted_item
end
