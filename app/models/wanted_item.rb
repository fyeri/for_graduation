class WantedItem < ApplicationRecord
  belongs_to :item

  validates :quantity, presence:true
end
