require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  
  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.build(:card)
  end

  describe 'POST #create' do
    context 'お気に入り登録ができる' do
      
      it '名刺情報がインスタンスに格納される' do
      end

      it 'HTTP200ステータスコードが返される' do
      end

      it 'トップページから移動しない' do
      
      end
    end
  end

  describe 'POST #destroy' do
    context 'お気に入り削除ができる' do
      
      it 'インスタンスの名刺情報が空になる' do
      end

      it 'HTTP200ステータスコードが返される' do
      end

      it 'トップページから移動しない' do
      
      end
    end
  end
  
end
