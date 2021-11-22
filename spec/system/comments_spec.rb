require 'rails_helper'

RSpec.describe "コメント機能 #create", type: :system do
  describe 'コメント投稿' do
  let!(:card) { FactoryBot.create(:card) }
  let(:comment) { FactoryBot.build(:comment) }
    context 'コメントを入力して投稿する時' do
      it 'コメントが投稿でき、名刺詳細ページで表示される' do
        # ログインする
        sign_in(card.user)
        # 名刺詳細ページに遷移する
        visit card_path(card)
        # コメントを入力する
        find("[data-testid='comment-text']").set(comment.text)
        find("[data-testid='comment-submit']").click
        visit current_path
        # 投稿したコメントが表示されている
        expect(page).to have_content comment.text
      end
    end
    context 'コメントを入力せず投稿する時' do
      it 'コメントが投稿できず、名刺詳細ページで表示されない' do
        # ログインする
        sign_in(card.user)
        # 名刺詳細ページに遷移する
        visit card_path(card)
        # コメントを入力する
        find("[data-testid='comment-text']").set('')
        # コメントを投稿すると、Commentモデルのカウントが上がらない
        expect{ 
          find("[data-testid='comment-submit']").click
          visit current_path
        }.to change { Comment.count }.by(0)
      end
    end
  end

  describe 'コメント削除 #destroy' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card) }
  let!(:comment) { FactoryBot.create(:comment, user_id: user.id, card_id: card.id ) }
    context 'コメント削除が成功する時' do
      it 'コメントが削除され、名刺詳細ページで表示されない' do
        # ログインする
        sign_in(user)
        # 名刺詳細ページに遷移する
        visit card_path(card)
        # コメントを削除する
        find("[data-testid='comment-delete']").click
        # 投稿したコメントが表示されていない
        expect(page).to have_no_content comment.text
      end
    end
  end
end
