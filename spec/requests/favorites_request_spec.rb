require 'rails_helper'

RSpec.describe "Favorites", type: :request do

  describe 'POST /cards/:card_id/favorites #create' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card) }
  subject { post "/cards/#{card.id}/favorites", params: { card_id: card.id } }
    context 'お気に入り登録する時' do
      it 'Favoriteモデルのカウントが+1される' do
        sign_in_request(user)
        expect{ subject }.to change {Favorite.count }.by(1)
      end
    end
  end

  describe 'POST /cards/:card_id/favorites #destroy' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card) }
  let!(:favorite) { FactoryBot.create(:favorite, card_id: card.id, user_id: user.id ) }
  subject { delete "/cards/#{card.id}/favorites", params: { card_id: card.id } } 
    context 'お気に入り削除するとき' do   
      it 'Favoriteモデルのカウントが-1される' do
        sign_in_request(user)
        expect{ subject }.to change { Favorite.count }.by(-1)
      end
    end
  end
end
