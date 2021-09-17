require 'rails_helper'

RSpec.describe "Records", type: :request do
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
      
      it '着信登録ページにリダイレクトされる' do
      
      end
    end
  end

  describe 'POST #create' do
    context '着信登録ができない' do
      it '着信登録ページにリダイレクトされる' do
      
      end
    end

    context '着信登録ができる' do
      it '着信情報がインスタンスに格納される' do
      end

      it 'HTTP200ステータスコードが返される' do
      end

      it '着信登録ページにリダイレクトされる' do
      
      end
    end
  end

  describe 'POST #destroy' do
    context '着信情報が削除できる' do
      
      it 'インスタンスの名刺情報が空になる' do
      end

      it 'HTTP200ステータスコードが返される' do
      end

      it 'トップページから移動しない' do
      
      end
    end
  end

  describe 'POST #import' do
    context '着信情報が登録できない' do
      it '着信登録ページから移動しない' do
      
      end
    end
  
    context '着信情報が登録できる' do
      it 'HTTP200ステータスコードが返される' do
        
      end

      it '着信登録ページにリダイレクトされる' do
      
      end
    end
  end

end
