require 'rails_helper'

RSpec.describe "Favorites", type: :request do

  describe 'POST /cards/:card_id/favorites #create' do
    let(:user) { FactoryBot.create(:user) }
    let(:card) { FactoryBot.create(:card) }
    context 'お気に入り登録ができる' do
      subject { post "/cards/#{card.id}/favorites", params: { card_id: card.id } }
      it 'Favoriteテーブルに登録される' do
        post user_session_path, params: { user: { email: user.email, password: user.password } }
        expect(response.status).to redirect_to root_path
        expect{ subject }.to change(Favorite, :count).by(1)
      end
    end
  end

  describe 'POST /cards/:card_id/favorites #destroy' do
    let(:user) { FactoryBot.create(:user) }
    let(:card) { FactoryBot.create(:card) }
    let(:favorite) { FactoryBot.create(:favorite, card_id: card.id, user_id: user.id ) }
    before do
      favorite
    end
    context 'お気に入り削除ができる' do   
      subject { delete "/cards/#{card.id}/favorites", params: { card_id: card.id } } 
      it 'Favoriteテーブルの登録が-1される' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: user.email, password: user.password } }
        expect(response.status).to redirect_to root_path
        expect{ subject }.to change(Favorite, :count).by(-1)
      end
    end
  end
end
