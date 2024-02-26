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
  describe '検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:label1) { FactoryBot.create(:label, name: "Label1", user: user) }
    let!(:label2) { FactoryBot.create(:label, name: "Label2", user: user) }
    let!(:first_item) { FactoryBot.create(:item, name: "first_item", character: "Character A", user: user, labels: [label1])}
    let!(:second_item) { FactoryBot.create(:item, name: "second_item", character: "Character B", user: user, labels: [label2])}
    let!(:third_item) { FactoryBot.create(:item, name: "third_item", character: "Character C", user: user)}

    context 'scopeメソッドで商品の曖昧検索した場合' do
      it "検索ワードを含む商品が絞り込まれる" do
        expect(Item.with_name('first')).to include(first_item)
        expect(Item.with_name('first')).not_to include(second_item)
        expect(Item.with_name('first')).not_to include(third_item)
        expect(Item.with_name('first').count).to eq 1
      end
    end
    context 'scopeメソッドでキャラクター名の曖昧検索をした場合' do
      it "検索ワードを含む商品が絞り込まれる" do
        expect(Item.with_character('A')).to include(first_item)
        expect(Item.with_character('A')).not_to include(second_item)
        expect(Item.with_character('A')).not_to include(third_item)
        expect(Item.with_character('A').count).to eq 1
      end
    end
    context 'scopeメソッドでラベルを検索した場合' do
      it 'ラベルに完全一致した商品が絞り込まれる' do
        expect(Item.with_label_name(label1.id)).to include(first_item)
        expect(Item.with_label_name(label1.id)).not_to include(second_item)
        expect(Item.with_label_name(label1.id)).not_to include(third_item)
        expect(Item.with_label_name(label1.id).count).to eq 1
      end
    end
    context 'scopeメソッドで商品名、キャラクター名の曖昧検索とラベル検索をした場合' do
      it '検索ワードを含んだ商品名、キャラクター名、かつラベルに完全一致する商品が絞り込まれる' do
        expect(Item.with_name('first').with_character('A').with_label_name(label1.id)).to include(first_item)
        expect(Item.with_name('first').with_character('A').with_label_name(label1.id)).not_to include(second_item)
        expect(Item.with_name('first').with_character('A').with_label_name(label1.id)).not_to include(third_item)
        expect(Item.with_name('first').with_character('A').with_label_name(label1.id).count).to eq 1

      end
    end
  end
end
