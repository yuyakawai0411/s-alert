require 'rails_helper'

RSpec.describe "Cards", type: :request do

  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.build(:card)
  end

  describe 'GET #new' do
    context '未登録ユーザーがアクセスした時' do 
      it 'トップページにリダイレクトされる' do
      
      end
    end

    context '登録済みユーザーがアクセスした時' do
      it 'HTTP200ステータスコードが返される' do
      end

      it '新規名刺登録ページにリダイレクトされる' do
      
      end
    end

  describe 'GET #edit' do
    context '未登録ユーザーがアクセスした時' do 
      it 'トップページにリダイレクトされる' do
      
      end
    end

    context '登録済みユーザーがアクセスした時' do
      it 'HTTP200ステータスコードが返される' do
      end

      it '名刺編集ページにリダイレクトされる' do
      
      end
    end
  end
  
  describe 'GET #show' do
    context '存在しない名刺にアクセスした時' do 
      it 'トップページにリダイレクトされる' do
      
      end
    end

    context '存在する名刺にアクセスした時' do
      it 'インスタンスに名刺情報が格納される' do
      
      end

      it 'HTTP200ステータスコードが返される' do
      
      end

      it '名刺詳細ページにリダイレクトされる' do
      
      end
      
    end
  end

  describe 'GET #search' do
    context '存在しない名刺を検索した時' do
      it 'インスタンスに名刺情報が格納されるない' do

      end
      it 'HTTP200ステータスコードが返される' do
      
      end

      it '検索結果ページにリダイレクトされる' do
      
      end
      
    end

    context '存在する名刺を検索した時' do
      it 'インスタンスに名刺情報が格納される' do

      end
      it 'HTTP200ステータスコードが返される' do
      
      end

      it '検索結果ページにリダイレクトされる' do
      
      end
      
    end
  end

  describe 'POST #create' do
    context '名刺登録できない' do 
      it '新規名刺登録ページにリダイレクトされる' do
      
      end
    end

    context '名刺登録できる' do
      it 'インスタンスに入力した情報が格納される' do
      
      end

      it 'HTTP200ステータスコードが返される' do
      
      end

      it 'トップページにリダイレクトされる' do
      
      end
      
    end
  end

  describe 'POST #update' do
    context '名刺編集できない' do 
      it '新規名刺登録ページにリダイレクトされる' do
      
      end
    end

    context '名刺編集できる' do
      it 'インスタンスに編集した情報が格納される' do
      
      end

      it 'HTTP200ステータスコードが返される' do
      
      end

      it 'トップページにリダイレクトされる' do
      
      end
      
    end
  end

  describe 'POST #destroy' do
    context '名刺削除できる' do
      it 'HTTP200ステータスコードが返される' do
      
      end

      it 'トップページにリダイレクトされる' do
      
      end
      
    end
  end

  describe 'POST #test_sign_in' do
    context 'テストログインできる' do
      it 'インスタンスにテストユーザー情報が格納される' do

      end
      it 'HTTP200ステータスコードが返される' do
      
      end

      it 'トップページにリダイレクトされる' do
      
      end
      
    end
  end

end
