require 'rails_helper'

RSpec.describe "Comments", type: :request do
  
  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.create(:card)
    @comment = FactoryBot.attributes_for(:comment, user_id: @user.id, card_id: @card.id)
  end

  describe 'POST /cards/:card_id/comments #create' do
    context 'コメントができる' do    
      it 'データベースにコメントが保存される' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @card.user.email, password: @card.user.password } }
        expect(response.status).to redirect_to root_path
        expect{
        post "/cards/#{@card.id}/comments", params: {comment: @comment, card_id: @card.id}
        }.to change { Comment.count }.by(1)
      end

      it 'ストリームにコメントが送信される' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @card.user.email, password: @card.user.password } }
        expect(response.status).to redirect_to root_path
        expect{
        post "/cards/#{@card.id}/comments", params: {comment: @comment, card_id: @card.id}
        }.to have_broadcasted_to('message_channel').with{ |data| expect(data['content'][:text]).to include @comment[:text] }
      end
    end
  end

end
