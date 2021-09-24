require 'rails_helper'

RSpec.describe "会話ネタのコメント", type: :system do
  before do
    @card = FactoryBot.create(:card)
    @comment = FactoryBot.build(:comment)
  end
  
  it 'ログインユーザーは名刺詳細ページでコメント投稿できる' do
    # basic_pass root_path
    # ログインする
    sign_in(@card.user)
    # 名刺詳細ページに遷移する
    visit card_path(@card)
    # コメントを入力する
    fill_in 'comment_text', with: @comment.text
    # コメントを投稿すると、Commentモデルのカウントが1上がる
    expect{
      find_by_id('comment-submit').click
    }.to change { Comment.count }.by(1)
    # 投稿したコメントが表示されている
    expect(page).to have_content @comment.text
  end
end
