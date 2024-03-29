class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  
  has_many :owned_items, dependent: :destroy
  has_many :wanted_items, dependent: :destroy
  has_many :items

  has_many :labels, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*\d)[a-z\d]{6,}+\z/

  validates :name, presence: true, length: { in: 1..255 }
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: "を○○@○○.○○の形式で入力して下さい" }, length: { maximum: 255 }

  validates :password, presence: true, length: { maximum: 255 }, format: { with: VALID_PASSWORD_REGEX, message: "を半角英数字6文字以上で入力して下さい" }, on: :create

  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = 'guest123'
      user.name = 'ゲスト'

    end
  end

  def self.guest_admin
    find_or_create_by!(email: 'guest_admin@example.com') do |user|
      user.password = 'guest123'
      user.name = 'ゲスト管理者'
      user.admin = true
    end
  end
end
