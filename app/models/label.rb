class Label < ApplicationRecord
  has_many :item_labels, dependent: :destroy
  has_many :items, through: :item_labels
end
