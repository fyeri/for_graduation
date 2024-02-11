class WantedItem < ApplicationRecord
  belongs_to :item
  mount_uploader :image, ImageUploader

  validates :quantity, presence:true
end
