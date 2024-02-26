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
  describe '検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:label1) { FactoryBot.create(:label, name: "Label1", user: user) }
    let!(:label2) { FactoryBot.create(:label, name: "Label2", user: user) }

    let!(:first_item) { FactoryBot.create(:item, name: "first_item", character: "Character A", user: user, labels: [label1])}
    let!(:wanted_item1) { create(:wanted_item, item: first_item, user: user) }

    let!(:second_item) { FactoryBot.create(:item, name: "second_item", character: "Character B", user: user, labels: [label2])}
    let!(:wanted_item2) { create(:wanted_item, item: second_item, user: user) }

    let!(:third_item) { FactoryBot.create(:item, name: "third_item", character: "Character C", user: user)}
    let!(:wanted_item3) { create(:wanted_item, item: third_item, user: user) }

    context 'scopeメソッドで商品の曖昧検索した場合' do
      it "検索ワードを含む商品が絞り込まれる" do
        expect(WantedItem.with_item_name('first')).to include(wanted_item1)
        expect(WantedItem.with_item_name('first')).not_to include(wanted_item2)
        expect(WantedItem.with_item_name('first')).not_to include(wanted_item3)
        expect(WantedItem.with_item_name('first').count).to eq 1
      end
    end
    context 'scopeメソッドでキャラクター名の曖昧検索をした場合' do
      it "検索ワードを含む商品が絞り込まれる" do
        expect(WantedItem.with_item_character('A')).to include(wanted_item1)
        expect(WantedItem.with_item_character('A')).not_to include(wanted_item2)
        expect(WantedItem.with_item_character('A')).not_to include(wanted_item3)
        expect(WantedItem.with_item_character('A').count).to eq 1
      end
    end
    context 'scopeメソッドでラベルを検索した場合' do
      it 'ラベルに完全一致した商品が絞り込まれる' do
        expect(WantedItem.with_label_name(label1.id)).to include(wanted_item1)
        expect(WantedItem.with_label_name(label1.id)).not_to include(wanted_item2)
        expect(WantedItem.with_label_name(label1.id)).not_to include(wanted_item3)
        expect(WantedItem.with_label_name(label1.id).count).to eq 1
      end
    end
    context 'scopeメソッドで商品名、キャラクター名の曖昧検索とラベル検索をした場合' do
      it '検索ワードを含んだ商品名、キャラクター名、かつラベルに完全一致する商品が絞り込まれる' do
        expect(WantedItem.with_item_name('first').with_item_character('A').with_label_name(label1.id)).to include(wanted_item1)
        expect(WantedItem.with_item_name('first').with_item_character('A').with_label_name(label1.id)).not_to include(wanted_item2)
        expect(WantedItem.with_item_name('first').with_item_character('A').with_label_name(label1.id)).not_to include(wanted_item3)
        expect(WantedItem.with_item_name('first').with_item_character('A').with_label_name(label1.id).count).to eq 1
      end
    end
  end
end
