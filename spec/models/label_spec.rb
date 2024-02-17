require 'rails_helper'

RSpec.describe Label, type: :model do
  it { should have_many(:items) }
  it { should have_many(:item_labels) }
  it { is_expected.to belong_to(:user) }

  describe 'ラベルモデルのバリデーションテスト' do
    it 'ラベルの名前が空文字の場合は無効' do
      user = create(:user)
      label = Label.new(name: nil, user:user)

      expect(label).to be_invalid
    end

    it 'ラベルの名前がある場合は有効' do
    user = create(:user)
    label = Label.new(name: "ラベル1", user:user)

    expect(label).to be_valid
    end
  end
end
