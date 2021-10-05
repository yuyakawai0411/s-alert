require 'rails_helper'

RSpec.describe "お気に入り登録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.create(:card)
  end

  context 'お気に入り登録できる' do
    it 'ログインユーザーはお気に入り登録と解除ができる' do
      # basic_pass root_path
      # ログインする
      sign_in(@user)
      # お気に入り登録リンクをクリック
      find_link('お気に入り登録').click
      expect(current_path).to eq(root_path)
      # ユーザー詳細ページに移動
      expect(page).to have_link "詳細", href: user_path(@user.id)
      visit user_path(@user)
      expect(current_path).to eq(user_path(@user.id))
      # ユーザーの詳細情報がある
      user_exist_page(@user)
      # ユーザー詳細ページにお気に入りした名刺がある
      expect(page).to have_selector ".favorites", text: @card.s_last_name
      expect(page).to have_selector ".favorites", text: @card.s_first_name
      expect(page).to have_selector ".favorites", text: @card.s_last_name_kana
      expect(page).to have_selector ".favorites", text: @card.s_first_name_kana
      expect(page).to have_selector ".favorites", text: @card.s_company
      expect(page).to have_selector ".favorites", text: @card.s_company_form.form
      expect(page).to have_selector ".favorites", text: @card.s_department
      expect(page).to have_selector ".favorites", text: @card.s_phone_number
      # お気に入りを解除する
      find_link('お気に入り解除').click
      visit user_path(@user)
      # ユーザー詳細ページの名刺が消えている
      expect(page).to have_no_selector ".favorites", text: @card.s_last_name
      expect(page).to have_no_selector ".favorites", text: @card.s_first_name
      expect(page).to have_no_selector ".favorites", text: @card.s_last_name_kana
      expect(page).to have_no_selector ".favorites", text: @card.s_first_name_kana
      expect(page).to have_no_selector ".favorites", text: @card.s_company
      expect(page).to have_no_selector ".favorites", text: @card.s_company_form.form
      expect(page).to have_no_selector ".favorites", text: @card.s_department
      expect(page).to have_no_selector ".favorites", text: @card.s_phone_number
    end
  end

  context 'お気に入り登録できない' do
    it 'ログインしていないユーザーはお気に入り登録ができない' do
      # トップページに移動
      visit root_path
      # お気に入り登録のリンクがない
      expect(page).to have_no_content 'お気に入り登録'
    end
  end

end

