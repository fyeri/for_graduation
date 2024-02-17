class Label < ApplicationRecord
  has_many :item_labels, dependent: :destroy
  has_many :items, through: :item_labels
  belongs_to :user

  validates :name, presence: {message: :blank},  length: { maximum: 255 }
  
end
