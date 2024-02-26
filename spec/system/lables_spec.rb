require 'rails_helper'

RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label,user:user) }

  describe 'ラベルのCRUD機能テスト' do
    before do
      visit new_user_session_path
      fill_in "user_email", with: "test@example.com"
      fill_in "user_password", with: "password1"
      click_button "ログイン"
    end

    it 'ラベルを登録した場合、登録したラベルが表示される' do
      click_link "label-index" 
      click_link "new_label"
      fill_in "label_name", with: "label_2"
      click_button "create-label"  
      expect(page).to have_content 'label_2'
    end

    it '一覧場面に遷移した場合、登録済みのラベル一覧が表示される' do         
      click_link "label-index"
      expect(page).to have_content 'label_1'   
    end

    it 'ラベルを更新した場合、更新されたラベルが表示される' do
      click_link "label-index"
      first('.show-label').click
      find(".edit-label").click
      fill_in "label_name", with: "ラベル１"
      click_button "update-label"
      expect(page).to have_content 'ラベル１'
      expect(page).not_to have_content 'label_1'
    end

    it 'ラベルを削除した場合、削除されたラベルは表示されない' do
      click_link "label-index"
      first('.show-label').click
      find(".edit-label").click
      page.accept_confirm do
        find(".destroy-label").click
      end 
      expect(page).not_to have_content 'label_1'
    end
  end
end