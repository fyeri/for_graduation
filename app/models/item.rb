class Item < ApplicationRecord
  has_many :item_labels
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

  enum category: { 缶バッチ: 0, キーホルダー: 1, アクリルスタンド: 2, ポストカード: 3, その他: 4 }

  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :with_name, ->(name) { where("items.name LIKE ?", "%#{name}%") if name.present? }
  scope :with_character, ->(character) { where("items.character LIKE ?", "%#{character}%") if character.present? }
  scope :with_label_name, ->(label_id) {
    joins(:labels).where('labels.id = ?', label_id).distinct if label_id.present?
  }

end

