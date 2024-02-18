require 'rails_helper'

RSpec.describe WantedItem, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:item) }

  describe '欲しいグッズのバリデーションに関するテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:item) { FactoryBot.create(:item, user: user) }

    it '数量がある場合有効' do
      wanted_item = WantedItem.new(quantity: 2, user:user, item: item )
      expect(wanted_item).to be_valid
    end

    it '数量が空なら無効' do
      wanted_item = WantedItem.new(quantity: nil, user:user, item: item ) 
      expect(wanted_item).to be_invalid
    end
  end
end
