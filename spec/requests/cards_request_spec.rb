require 'rails_helper'

RSpec.describe "Cards", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:card) { FactoryBot.create(:card) }

  describe 'GET / #index' do 
    it 'トップページにアクセスされる' do
      get root_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET /cards/new #new' do
    context '名刺投稿者がアクセスするとき' do 
      it '名刺作成ページにアクセスでき、HTTP200ステータスコードが返される' do
        post user_session_path, params: { user: { email: user.email, password: user.password } }
        expect(response.status).to redirect_to root_path
        get new_card_path
        expect(response.status).to eq 200
      end
    end
    context '未ログインユーザーがアクセスするとき' do 
      it 'ログインページにリダイレクトされる' do
        get new_card_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /cards/edit/:id #edit' do
    context '名刺投稿者がアクセスするとき' do 
      before do
        post user_session_path, params: { user: { email: card.user.email, password: card.user.password } }
        expect(response.status).to redirect_to root_path
        get edit_card_path card.id
      end
      it '名刺編集ページにアクセスでき、HTTP200ステータスコードが返される' do
        expect(response.status).to eq 200
      end
      it '投稿した名刺の情報が含まれている' do
        expect(response.body).to include(card.s_last_name)
      end
    end
    context '名刺投稿者以外がアクセスするとき' do 
      it 'トップページにリダイレクトされる' do
        post user_session_path, params: { user: { email: user.email, password: user.password } }
        get edit_card_path card.id
        expect(response).to redirect_to root_path
      end
    end
    context '未ログインユーザーがアクセスするとき' do 
      it 'ログインページにリダイレクトされる' do
        get edit_card_path card.id
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  
  describe 'GET /cards/:id #show' do
    before do
      get card_path card.id
    end
    it '名刺詳細ページにアクセスでき、HTTP200ステータスコードが返される' do
      expect(response.status).to eq 200
    end
    it '投稿した名刺の情報が含まれている' do
      expect(response.body).to include(card.s_last_name)
    end
  end

  describe 'GET /cards/search #search' do
    let(:card_another) { FactoryBot.create(:card) }
    context '存在する名刺を検索したとき' do
      before do 
        get search_cards_path, params: { keyword: card.s_last_name }
      end
      it 'HTTPステータスコード200が返される' do
        expect(response.status).to eq 200
      end
      it '名刺がレスポンスに含まれる' do
        expect(response.body).to include(card.s_last_name)
        expect(response.body).not_to include(card_another.s_last_name)
      end
    end
    context '存在しない名刺を検索したとき' do
      before do
        get search_cards_path, params: { keyword: 'kawai' }
      end
      it 'HTTPステータスコード200が返される' do
        expect(response.status).to eq 200
      end
      it '名刺がレスポンスに含まれない' do
        expect(response.body).not_to include(card.s_last_name)
        expect(response.body).not_to include(card_another.s_last_name)
      end
    end
    context '空で検索したとき' do
      it '投稿されている名刺全てが表示され、HTTPステータスコード200が返される' do
        get search_cards_path, params: { keyword: '' }
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /cards #create' do
    let(:card_post) { FactoryBot.attributes_for(:card) }
    let(:card_wothout_name) { FactoryBot.attributes_for(:card, s_last_name: '') } 
    context '名刺投稿者がアクセスしたとき' do
      before do
        post user_session_path, params: { user: { email: card.user.email, password: card.user.password } }
        expect(response.status).to redirect_to root_path
      end
      context '名刺登録に必要な情報を全て入力したとき' do 
        it '名刺がデータベースに登録され、トップページにリダイレクトされる' do
          expect{
          post cards_path, params: { card: card_post }
          }.to change(Card, :count).by(1)
          expect(response).to redirect_to root_path
        end
      end
      context '名刺登録に必要な情報を入力しなかったとき' do
        it '名刺がデータベースに登録されず、エラーメッセージが表示される' do
          expect{
          post cards_path, params: { card: card_wothout_name }
          }.to change(Card, :count).by(0)
          expect(response.body).to include('姓を入力してください') 
        end
      end
    end
    context '未ログインユーザーがアクセスするとき' do 
      it '名刺がデータベースに登録されず、ログインページにリダイレクトされる' do
        expect{
          post cards_path, params: { card: card_post }
          }.to change(Card, :count).by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PUT /cards/:id #update' do
    let(:card_post) { FactoryBot.attributes_for(:card) }
    let(:card_wothout_name) { FactoryBot.attributes_for(:card, s_last_name: '') } 
    context '名刺投稿者がアクセスしたとき' do
      before do
        post user_session_path, params: { user: { email: card.user.email, password: card.user.password } }
        expect(response.status).to redirect_to root_path
      end
      context '名刺編集に必要な情報を全て入力したとき' do 
        it '名刺が編集され、トップページにリダイレクトされる' do
          expect{
            put card_path card.id, params: { card: card_post }
          }.to change { Card.find(card.id).s_last_name }.from(card.s_last_name).to(card_post[:s_last_name]) 
          expect(response).to redirect_to root_path
        end
      end
      context '名刺編集に必要な情報を記入しないとき' do
        it '名刺が編集されず、エラーが表示される' do
          expect{
            put card_path card.id, params: { card: card_wothout_name }
          }.not_to change(Card.find(card.id), :s_last_name)
          expect(response.body).to include('姓を入力してください') 
        end
      end
    end
    context '名刺投稿者以外がアクセスするとき' do 
      it '名刺が変更されず、トップページにリダイレクトされる' do
        post user_session_path, params: { user: { email: user.email, password: user.password } }
        expect(response.status).to redirect_to root_path
        expect{
          put card_path card.id, params: { card: card_post }
        }.not_to change(Card.find(card.id), :s_last_name)
        expect(response).to redirect_to root_path
      end
    end
    context '未ログインユーザーがアクセスするとき' do 
      it '名刺が変更されず、、ログインページにリダイレクトされる' do
        expect{
          put card_path card.id, params: { card: card }
        }.not_to change(Card.find(card.id), :s_last_name)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context '名刺投稿者がアクセスしたとき' do
      it '名刺がデータベースから削除され、トップページにリダイレクトされる' do
        post user_session_path, params: { user: { email: card.user.email, password: card.user.password } }
        expect(response.status).to redirect_to root_path
        expect{
          delete card_path card
        }.to change(Card, :count).by(-1)
        expect(response).to redirect_to root_path
      end
    end
    context '名刺投稿者以外がアクセスするとき' do 
      it '名刺がデータベースから削除されず、トップページにリダイレクトされる' do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      expect(response.status).to redirect_to root_path
      expect{
        delete card_path card
      }.to change(Card, :count).by(1)
      expect(response).to redirect_to root_path
      end
    end
    context '未ログインユーザーがアクセスするとき' do 
      it '名刺がデータベースから削除されず、ログインページにリダイレクトされる' do
      expect{
        delete card_path card
      }.to change(Card, :count).by(1)
      expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
