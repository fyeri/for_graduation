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
  describe 'ユーザ登録' do
    context ''
      

end
