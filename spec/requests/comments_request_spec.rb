require 'rails_helper'

RSpec.describe "Comments", type: :request do

  describe 'POST /cards/:card_id/comments #create' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card) }
  let(:comment) { FactoryBot.attributes_for(:comment, user_id: user.id, card_id: card.id) }
  subject { post "/cards/#{card.id}/comments", params: {comment: comment } }
    context 'ログインユーザーがコメントを投稿する時' do    
    before do
      sign_in_request(user)
    end
      it 'データベースにコメントが保存される' do
        expect{ subject }.to change(Comment, :count).by(1)
      end
      it 'ストリームにコメントが送信される' do
        expect{ subject }.to have_broadcasted_to('message_channel').with{ |data| expect(data['content'][:text]).to include comment[:text] }
      end
    end
    context '未ログインユーザーがコメントを投稿する時' do
      it 'コメントできず、ログインページにリダイレクトされる' do
        expect{ subject }.to change { Comment.count }.by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE /cards/:card_id/comments/:id #destory' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card) }
  let!(:comment) { FactoryBot.create(:comment, card_id: card.id, user_id: user.id) }
  subject { delete "/cards/#{card.id}/comments/#{comment.id}", params: {id: comment.id, card_id: card.id } }
    context 'コメント投稿者がコメントを削除するとき' do    
      it 'データベースからコメントが削除される' do
        sign_in_request(user)
        expect{ subject }.to change { Comment.count }.by(-1)
        expect(response).to redirect_to "/cards/#{card.id}"
      end
    end
    context '未ログインユーザーがコメントを投稿する時' do
      it 'コメントできず、ログインページにリダイレクトされる' do
        expect{ subject }.to change { Comment.count }.by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
