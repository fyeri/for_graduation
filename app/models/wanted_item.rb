class WantedItem < ApplicationRecord
  belongs_to :item, dependent: :destroy
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
