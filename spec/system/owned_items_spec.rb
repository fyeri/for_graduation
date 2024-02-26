require 'rails_helper'

RSpec.describe "OwnedItems", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label, user: user) }

  let!(:item) { FactoryBot.create(:item, labels: [label], user: user) }
  let!(:second_item) { FactoryBot.create(:second_item, user: user) }
  let!(:third_item) { FactoryBot.create(:third_item, user: user) }


  let!(:owned_item) { FactoryBot.create(:owned_item, item: item, user: user) }
  let!(:second_owned_item ) { FactoryBot.create(:second_owned_item, item: second_item, user: user) }
  let!(:third_owned_item) { FactoryBot.create(:third_owned_item, item: third_item, user: user) }

  describe '持っているグッズの表示テスト' do
    before do
      visit new_user_session_path
      fill_in "user_email", with: "test@example.com"
      fill_in "user_password", with: "password1"
      click_button "ログイン"
    end

    it '持っているグッズを登録した場合、一番最初に表示される' do
      click_link "new-item"
      sleep 0.1
      fill_in "item_name", with: "test2"
      fill_in "item_character", with: "test2"
      select "キーホルダー", from: "item_category"
      click_button "create-item"
      click_link "owned-items-index"
      sleep 0.1
      expect(all('.item-name').map(&:text)).to eq(["test2", "cc", "bb", "aa"])
    end

    it '任意のグッズ詳細画面に遷移いた場合、そのグッズの内容が表示される' do
      first('.show-item').click
      expect(page).to have_content 'グッズ詳細'
    end
  end

  describe '検索機能テスト' do
    before do
      visit new_user_session_path
      fill_in "user_email", with: "test@example.com"
      fill_in "user_password", with: "password1"
      click_button "ログイン"
    end

    it '商品名で曖昧検索した場合、検索ワードを含むグッズが表示される' do
      sleep 0.1
      fill_in "item_name", with: "a"
      click_button "search-btn"
      sleep 0.1
      expect(page).to have_content, 'aa'
      expect(page).not_to have_content 'bb'
      expect(page).not_to have_content 'cc'
    end

    it 'キャラクター名で曖昧検索した場合、検索ワードを含むグッズが表示される' do
      sleep 0.1
      fill_in "item_character", with: "a"
      click_button "search-btn"
      sleep 0.1
      expect(page).to have_content 'aa'
      expect(page).not_to have_content 'bb'
      expect(page).not_to have_content 'cc'
    end

    it 'ラベルで検索した場合、そのラベルのついたグッズが表示される' do
      sleep 0.1
      select "label_1", from: "item_label_ids"
      click_button "search-btn"
      sleep 0.1
      expect(page).to have_content 'aa'
      expect(page).not_to have_content 'bb'
      expect(page).not_to have_content 'cc'
    end
  end
end