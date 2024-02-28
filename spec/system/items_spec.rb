require 'rails_helper'

RSpec.describe "Items", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label, user: user) }

  let!(:item) { FactoryBot.create(:item, labels: [label], user: user) }
  let!(:second_item) { FactoryBot.create(:second_item, user: user) }
  let!(:third_item) { FactoryBot.create(:third_item, user: user) }


  let!(:owned_item) { FactoryBot.create(:owned_item, item: item, user: user) }
  let!(:second_owned_item ) { FactoryBot.create(:second_owned_item, item: second_item, user: user) }
  let!(:third_owned_item) { FactoryBot.create(:third_owned_item, item: third_item, user: user) }

  describe 'アイテムのCRUD機能テスト' do
    before do
      visit new_user_session_path
      fill_in "user_email", with: "test@example.com"
      fill_in "user_password", with: "password1"
      click_button "ログイン"
    end

    it 'アイテムを登録した場合、登録したアイテムが表示される' do
      click_link "new-item"
      sleep 0.1
      fill_in "item_name", with: "test2"
      fill_in "item_character", with: "test2"
      select "キーホルダー", from: "item_category"
      fill_in "item_purchased_on", with: "002024-02-29"
      choose "item_item_type_wanted"
      fill_in "item_quantity", with: "2"
      click_button "create-item"
      sleep 0.1
      expect(page).to have_content '新規グッズを登録しました'
    end

    it 'アイテムを更新した場合、更新したアイテムが表示される' do
      first('.show-item').click
      sleep 0.1
      find(".edit-item").click
      sleep 0.1
      fill_in "item_purchased_on", with: "002024-02-29"
      click_button "update-item"
      sleep 0.1
      expect(page).to have_content 'グッズを更新しました'
    end

    it 'アイテムを持っているグッズから欲しいグッズに更新した場合、欲しいグッズとして表示される' do
      first('.show-item').click
      sleep 0.1
      find(".edit-item").click
      sleep 0.1
      choose "item_item_type_wanted"
      fill_in "item_quantity", with: "2"
      click_button "update-item"
      sleep 0.1
      expect(page).to have_content '欲しいグッズ'
    end

    it 'アイテムを更新した場合、アイテムが削除される' do
      first('.show-item').click
      sleep 0.1
      find(".edit-item").click
      sleep 0.1
      page.accept_confirm do
        find(".destroy-item").click
      end
      sleep 0.1
      expect(page).to have_content 'グッズを削除しました'
    end

    it 'キーホルダーをクリックするとキーホルダーのみが表示される' do
      find(".キーホルダー-link").click
      sleep 0.1
      expect(page).to have_content 'aa'
      expect(page).to have_content 'bb'
      expect(page).not_to have_content 'cc'
    end
  end
  
  describe '検索機能テスト'do
    before do
      visit new_user_session_path
      fill_in "user_email", with: "test@example.com"
      fill_in "user_password", with: "password1"
      click_button "ログイン"
      find(".キーホルダー-link").click
    end

    it '商品名で曖昧検索した場合、検索ワードを含むグッズが表示される' do
      fill_in "item_name", with: "a"
      click_button "search-btn"
      sleep 0.1
      expect(page).to have_content 'aa'
      expect(page).not_to have_content 'bb'
    end
    
    it 'キャラクター名で曖昧検索した場合、検索ワードを含むグッズが表示される' do
      fill_in "item_character", with: "a"
      sleep 0.1
      click_button "search-btn"
      sleep 0.1
      expect(page).to have_content 'aa'
      expect(page).not_to have_content 'bb'
    end
      
    it 'ラベルで検索した場合、そのラベルのついたグッズが表示される' do
      select "label_1", from: "item_label_ids"
      sleep 0.1
      click_button "search-btn"
      sleep 0.1
      expect(page).to have_content 'aa'
      expect(page).not_to have_content 'bb'
    end
  end
end