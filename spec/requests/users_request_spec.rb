require 'rails_helper'

RSpec.describe "Users", type: :request do

  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.build(:card)
  end

  describe 'GET #show' do
    context '未登録ユーザーがアクセスした時' do 
      it 'トップページにリダイレクトされる' do
      
      end
    end

    context '登録済みユーザーがアクセスした時' do
      it 'HTTP200ステータスコードが返される' do
      end

      it 'ユーザー詳細ページにリダイレクトされる' do
      
      end
    end
  end
end
