class Item < ApplicationRecord
  has_many :item_labels, dependent: :destroy
  has_many :labels, through: :item_labels
  has_one :owned_item, dependent: :destroy
  has_one :wanted_item, dependent: :destroy
  belongs_to :user
  attr_accessor :item_type


  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :owned_item, allow_destroy: true
  accepts_nested_attributes_for :wanted_item, allow_destroy: true

  validates :name, presence: {message: :blank},  length: { maximum: 255 }
  validates :character, presence: {message: :blank}, length: { maximum: 255 }
  validates :category, presence: {message: :blank}
  validates :purchased_on, presence: {message: :blank}

  enum category: { 缶バッチ: 0, キーホルダー: 1, アクリルスタンド: 2, ポストカード: 3, その他: 4 }
end
