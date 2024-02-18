require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should have_many(:labels) }
  it { should have_one(:owned_item) }
  it { should have_one(:wanted_item) }

  describe 'アイテムのバリデーションに関するテスト' do
    let!(:user) { FactoryBot.create(:user) }
    it '名前、キャラクター名、カテゴリーが入っている場合登録が成功する' do
      item = Item.new(name: "b", character: "bb", category: 1, user: user)

      expect(item).to be_valid
    end
    it 'アイテムの名前が空文字だった場合は無効' do
      item = Item.new(name: nil, character: "bb", category: 1, user: user)

      expect(item).to be_invalid
    end
    it 'アイテムのキャラクターが空文字だった場合無効' do
      item = Item.new(name: "b", character: nil, category: 1, user: user)

      expect(item).to be_invalid
    end
    it 'アイテムのカテゴリーが空文字だった場合無効' do
      item = Item.new(name: "b", character: "bb", category: nil, user: user)

      expect(item).to be_invalid
    end
  end
end
