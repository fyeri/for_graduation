class WantedItem < ApplicationRecord
  belongs_to :item, dependent: :destroy
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  scope :for_user, ->(user_id) { where(user_id: user_id) }

  scope :with_item_name, ->(name) {
    joins(:item).where('items.name LIKE ?', "%#{name}%") if name.present?
  }

  scope :with_item_character, ->(character) {
    joins(:item).where('items.character LIKE ?', "%#{character}%") if character.present?
  }

  scope :with_label_name, ->(label_name) {
    joins(item: :labels).where('labels.name LIKE ?', "%#{label_name}%").distinct if label_name.present?
  }

end
