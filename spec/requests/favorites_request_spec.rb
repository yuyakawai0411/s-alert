require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  
  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.create(:card)
  end

  describe 'POST /cards/:card_id/favorites #create' do
    context 'お気に入り登録ができる' do
      it 'Favoriteテーブルに登録される' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @user.email, password: @user.password } }
        expect(response.status).to redirect_to root_path
        expect{
        post "/cards/#{@card.id}/favorites", params: { card_id: @card.id }
        }.to change(Favorite, :count).by(1)
      end
    end
  end

  describe 'POST /cards/:card_id/favorites #destroy' do
    context 'お気に入り削除ができる' do    
      it 'Favoriteテーブルの登録が-1される' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @user.email, password: @user.password } }
        expect(response.status).to redirect_to root_path
        expect{
        post "/cards/#{@card.id}/favorites", params: { card_id: @card.id }
        }.to change(Favorite, :count).by(1)
        expect{
          delete "/cards/#{@card.id}/favorites", params: { card_id: @card.id }
          }.to change(Favorite, :count).by(-1)
      end
    end
  end
end
