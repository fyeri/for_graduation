class OwnedItem < ApplicationRecord
  belongs_to :item
  mount_uploader :image, ImageUploader

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
