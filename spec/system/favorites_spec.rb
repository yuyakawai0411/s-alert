require 'rails_helper'

RSpec.describe "お気に入り機能", type: :system do
  
  describe 'お気に入り登録 #create' do
    context 'お気に入り登録するとき' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:card) { FactoryBot.create(:card) }
      it 'お気に入り登録した名刺がユーザー詳細ページで確認できる' do
        # ログインする
        sign_in(user)
        # ユーザー詳細ページのリンクがある
        expect(page).to have_link "詳細", href: user_path(user.id)
        # ユーザー詳細ページに移動
        visit user_path(user)
        expect(current_path).to eq(user_path(user.id))
        # お気に入りの名刺が存在しない
        card_favorite_not_exist_page(card)
        # トップページに移動する
        visit root_path
        # お気に入り登録リンクをクリック
        find("[data-testid='favorite-registration']").click
        # ユーザー詳細ページにお気に入りした名刺がある
        visit user_path(user)
        card_favorite_exist_page(card)
      end
    end
  end

  describe 'お気に入り解除 #destroy' do
    context 'お気に入り解除するとき' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:card) { FactoryBot.create(:card) }
    let!(:favorite) { FactoryBot.create(:favorite, user_id: user.id, card_id: card.id) }
      it 'お気に入り登録した名刺がユーザー詳細ページで確認できる' do
        # ログインする
        sign_in(user)
        # ユーザー詳細ページのリンクがある
        expect(page).to have_link "詳細", href: user_path(user.id)
        # ユーザー詳細ページに移動
        visit user_path(user)
        expect(current_path).to eq(user_path(user.id))
        # お気に入りした名刺が存在する
        card_favorite_exist_page(card)
        # お気に入り解除リンクをクリック
        find("[data-testid='favorite-cancel']").click
        # ユーザー詳細ページにお気に入りした名刺が存在しない
        visit user_path(user)
        card_favorite_not_exist_page(card)
      end
    end
  end
end

