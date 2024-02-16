require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should have_many(:labels) }
  it { should have_one(:owned_item) }
  it { should have_one(:wanted_item) }

  describe 'アイテムのバリデーションに関するテスト' do
    it 'アイテムの名前が入っている場合登録が成功する' do
      user = create(:user)
      item = Item.new(name: "b", character: "bb", category: 1, purchased_on: Date.today, user: user)

      expect(item).to be_valid
    end
  end
end
