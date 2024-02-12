class Item < ApplicationRecord
  has_many :item_labels
  has_many :labels, through: :item_labels
  has_one :owned_item
  has_one :wanted_item

  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :owned_item, allow_destroy: true
  accepts_nested_attributes_for :wanted_item, allow_destroy: true

  validates :name, presence: {message: :blank},  length: { maximum: 255 }
  validates :character, presence: {message: :blank}, length: { maximum: 255 }
  validates :category, presence: {message: :blank}
  validates :purchased_on, presence: {message: :blank}

  enum category: { 缶バッチ: 0, キーホルダー: 1, アクリルスタンド: 2, ポストカード: 3, その他: 4 }


  # validate :item_type_selection
  # # validate :quantity_presence

  # private

  # def item_type_selection
  #   unless owned_item || wanted_item
  #     errors.add(:base, "Item type must be selected.")
  #   end
  # end

  # def quantity_presence
  #   if owned_item && owned_item.quantity.blank?
  #     errors.add(:base, "Quantity must be provided for owned item.")
  #   elsif wanted_item && wanted_item.quantity.blank?
  #     errors.add(:base, "Quantity must be provided for wanted item.") 
  #   end
  # end
end
