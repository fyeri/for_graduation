require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }

  describe '登録機能' do
    context 'ユーザを登録した場合' do
      it '持っているグッズ一覧画面に遷移する' do

        visit new_user_session_path
        click_link "new-session" 
        fill_in "user_name", with: "user"
        fill_in "user_email", with: "user@example.com"
        fill_in "user_password", with: "password1"
        fill_in "user_password_confirmation", with: "password1"
        click_button "アカウント登録"

        expect(page).to have_content('持っているグッズ')
      end
    end
    context 'ログインせずに持っているグッズ一覧に遷移した場合' do
      it 'ログイン画面に遷移する' do
        visit new_user_session_path
        visit owned_items_path
        expect(page).to have_content('ログイン')
      end
    end
  end
  describe 'ログイン機能' do
    context '登録済みのユーザでログインした場合' do
      before do
        visit new_user_session_path
        fill_in "user_email", with: "test@example.com"
        fill_in "user_password", with: "password1"
        click_button "ログイン"
      end
      it '持っているグッズ一覧画面に遷移し、「ログインしました」というメッセージが表示される' do
        expect(page).to have_content('ログインしました')
      end
      it '自分のアカウント詳細画面に遷移できる' do
        click_link "user-show"
        expect(page).to have_content('user1')
      end
      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」と表示される' do
        click_link "sign-out"
        expect(page).to have_content('ログアウトしました')
      end
    end
  end
  describe '管理者機能' do
    context '管理者がログインした場合' do
      
      before do
        visit new_user_session_path
        fill_in "user_email", with: "admin@example.com"
        fill_in "user_password", with: "password1"
        click_button "ログイン"
      end
      it '管理者画面に遷移できる' do
      click_button "管理者用ページはこちら！"
      expect(page).to have_content('サイト管理')
      end
    end
  end
  context '一般ユーザが管理者画面にアクセスした場合' do
    before do
      visit new_user_session_path
      fill_in "user_email", with: "test@example.com"
      fill_in "user_password", with: "password1"
      click_button "ログイン"
    end

    it '持っているアイテム一覧画面に遷移し、「管理者権限がないのでアクセスできません」と言いうエラーメッセージが表示される' do
      visit rails_admin_path
      expect(page).to have_content('管理者権限がないのでアクセスできません')
    end
  end
end
