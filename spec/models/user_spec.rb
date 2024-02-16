require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:items) }
  it { should have_many(:owned_items) }
  it { should have_many(:wanted_items) }

  describe '欲しいグッズと持っているグッズをユーザに紐付け登録する' do
    it '動作確認' do
      user = create(:user)

      item = create(:item, user: user)
      owned_item = create(:owned_item, user: user, item: item)
      wanted_item = create(:wanted_item, user: user, item: item)

      expect(owned_item).to be_valid
      expect(wanted_item).to be_valid
      expect(user.owned_items).to include(owned_item)
      expect(user.wanted_items).to include(wanted_item)
    end
  end

  describe 'ユーザのバリデーションに関するテスト' do
    it '名前、メールアドレス、パスワードがある場合は有効' do
     user = create(:user)
     expect(user).to be_valid
    end
    it 'ユーザの名前が空文字の場合は無効' do
      user = User.new(name: nil, email: "user@example.com", password: "password2")
      expect(user).to be_invalid
    end
    it 'ユーザのメールアドレスが空文字の場合は無効' do
      user = User.new(name: "user2", email: nil, password: "password2")
      expect(user).to be_invalid
    end
    it 'ユーザのパスワードが空文字の場合は無効' do
      user = User.new(name: "user2", email: "user@example.com", password: nil )
      expect(user).to be_invalid
    end
    it 'ユーザのメールアドレスがすでに使用されている場合は無効' do
      user = create(:user)
      user1 = User.new(name: "user1", email: "test@example.com", password: "password2")
      expect(user1).to be_invalid
    end
    it 'パスワードが6文字未満または英数字を使っていない場合は無効' do
      user1 = User.new(name: "user1", email: "user1@example.com",
      password: "pass1")
      user2 = User.new(name: "user2", email: "user2@example.com", password: "password")
      expect(user1).to be_invalid
      expect(user2).to be_invalid
    end
    it 'メールアドレスが○○@○○.○○の形式になっていない場合は無効' do
      user = User.new(name: "user1", email: "user1-example.com", password: "password1")
      expect(user).to be_invalid
    end
  end
end
