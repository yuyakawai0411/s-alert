require 'rails_helper'

RSpec.describe "Notices", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.build(:card)
  end

  describe 'GET #index' do
    context '未登録ユーザーがアクセスした時' do
      it 'トップページにリダイレクトされる' do
      
      end
    end
    context '登録ユーザーがアクセスした時' do
      it 'HTTPステータスコード200が返される' do
      
      end

      it '通知登録ページにリダイレクトされる' do
      
      end
    end
  end

  describe 'POST #create' do
    context '通知登録ができない' do
      it '通知登録ページにリダイレクトされる' do
      
      end
    end

    context '通知登録ができる' do
      it '通知情報がインスタンスに格納される' do
      end

      it 'HTTP200ステータスコードが返される' do
      end

      it '通知登録ページにリダイレクトされる' do
      
      end
    end
  end

  describe 'POST #destroy' do
    context '通知情報が削除できる' do
      
      it 'インスタンスの通知情報が空になる' do
      end

      it 'HTTP200ステータスコードが返される' do
      end

      it 'トップページから移動しない' do
      
      end
    end
  end
end
