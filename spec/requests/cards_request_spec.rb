require 'rails_helper'

RSpec.describe "Cards", type: :request do

  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.create(:card)
    @card2 = FactoryBot.create(:card)
  end

  describe 'GET / #index' do 
    it 'ユーザーがトップページにアクセスできる' do
      get root_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET /cards/new #new' do
    context '未ログインユーザーがアクセス' do 
      it 'トップページにリダイレクトされる' do
        get new_card_path
        expect(response).to redirect_to new_user_session_path
      end
    end
    context 'ログインユーザーがアクセス' do 
      it '新規名刺登録ページにアクセスでき、HTTP200ステータスコードが返される' do
        get new_user_session_path
        post user_session_path, params: { user: { email: @user.email, password: @user.password } }
        expect(response.status).to redirect_to root_path
        get new_card_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET /cards/edit/:id #edit' do
    context '名刺作成者以外がアクセス' do 
      it 'トップページにリダイレクトされる' do
        get edit_card_path @card.id
        expect(response).to redirect_to new_user_session_path
      end
    end
    context '名刺作成者本人がアクセス' do 
      it '新規名刺登録ページにアクセスでき、HTTP200ステータスコードが返される' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @card.user.email, password: @card.user.password } }
        expect(response.status).to redirect_to root_path
        get edit_card_path @card.id
        expect(response.status).to eq 200
        expect(response.body).to include(@card.s_last_name)
      end
    end
  end
  
  describe 'GET /cards/:id #show' do
    context '名刺詳細にアクセスできる' do 
      it '新規名刺登録ページにアクセスでき、HTTP200ステータスコードが返される' do
        get card_path @card.id
        expect(response.status).to eq 200
        expect(response.body).to include(@card.s_last_name)
      end
    end
  end

  describe 'GET /cards/search #search' do
    context '存在する名刺を検索' do
      it '名刺がレスポンスに含まれる' do
        get search_cards_path, params: { keyword: @card.s_last_name }
        expect(response.status).to eq 200
        expect(response.body).to include(@card.s_last_name)
        expect(response.body).not_to include(@card2.s_last_name)
      end
    end
    context '存在する名刺を検索' do
      it '名刺がレスポンスに含まれない' do
        get search_cards_path, params: { keyword: 'kawai' }
        expect(response.status).to eq 200
        expect(response.body).not_to include(@card.s_last_name)
        expect(response.body).not_to include(@card2.s_last_name)
      end
    end
    context '入力せずに検索' do
      it '全ての名刺がレスポンスに含まれる' do
        get search_cards_path, params: { keyword: '' }
        expect(response.status).to eq 200
        expect(response.body).to include(@card.s_last_name)
        expect(response.body).to include(@card2.s_last_name)
      end
    end
  end

  describe 'POST /cards/test_sign_in #show' do
    context '名刺詳細にアクセスできる' do 
      it 'テストユーザーでサインインできる' do
        post cards_test_sign_in_path
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST /cards #create' do
    context '名刺登録に必要な情報を全て入力' do 
      it '名刺が登録され、トップページにリダイレクトされる' do
        post cards_test_sign_in_path
        expect(response).to redirect_to root_path
        expect{
        post cards_path, params: { card: FactoryBot.attributes_for(:card) }
        }.to change { Card.count }.by(1)
        expect(response).to redirect_to root_path
      end
    end

    context '名刺登録に必要な情報を登録しない' do
      it '名刺が登録されず、エラーメッセージが表示される' do
        post cards_test_sign_in_path
        expect(response).to redirect_to root_path
        expect{
        post cards_path, params: { card: FactoryBot.attributes_for(:card, s_last_name: '') }
        }.to change { Card.count }.by(0)
        expect(response.body).to include('姓を入力してください') 
      end
      
    end
  end

  describe 'PUT /cards/:id #update' do
    context '名刺編集に必要な情報を全て入力' do 
      it '名刺が編集され、トップページにリダイレクトされる' do
        card_edit = FactoryBot.attributes_for(:card)
        get new_user_session_path 
        post user_session_path, params: { user: { email: @card.user.email, password: @card.user.password } }
        expect(response.status).to redirect_to root_path
        expect{
          put card_path @card.id, params: { card: card_edit }
        }.to change { Card.find(@card.id).s_last_name }.from(@card.s_last_name).to(card_edit[:s_last_name]) 
        expect(response).to redirect_to root_path
      end
    end

    context '名刺編集に必要な情報を記入しない' do
      it '名刺が編集されず、エラーが表示される' do
        card_edit = FactoryBot.attributes_for(:card, s_last_name:'')
        get new_user_session_path 
        post user_session_path, params: { user: { email: @card.user.email, password: @card.user.password } }
        expect(response.status).to redirect_to root_path
        expect{
          put card_path @card.id, params: { card: card_edit }
        }.not_to change(Card.find(@card.id), :s_last_name)
        expect(response.body).to include('姓を入力してください') 
      end
    end
  end

  describe 'POST #destroy' do
    context '名刺削除できる' do
      it '名刺が削除され、トップページにリダイレクトされる' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @card.user.email, password: @card.user.password } }
        expect(response.status).to redirect_to root_path
        expect{
          delete card_path @card
        }.to change(Card, :count).by(-1)
        expect(response).to redirect_to root_path
      end
    end
  end

end
