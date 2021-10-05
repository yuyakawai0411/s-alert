require 'rails_helper'

RSpec.describe "Cards", type: :request do
  
  describe 'GET / #index' do 
    it 'トップページにアクセスされる' do
      get root_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET /cards/new #new' do
  let!(:user) { FactoryBot.create(:user) }
    context 'ログインユーザーがアクセスするとき' do 
      it '名刺作成ページにアクセスでき、HTTP200ステータスコードが返される' do
        sign_in_request(user)
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
  let!(:user) { FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card) }
    context '名刺投稿者がアクセスするとき' do 
      it '名刺編集ページにアクセスでき、投稿した名刺の情報が含まれている' do
        sign_in_request(card.user)
        get edit_card_path card.id
        expect(response.status).to eq 200
        expect(response.body).to include(card.s_last_name)
      end
    end
    context '名刺投稿者以外がアクセスするとき' do 
      it 'トップページにリダイレクトされる' do
        sign_in_request(user)
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
  let!(:card) { FactoryBot.create(:card) }
    it '名刺詳細ページにアクセスでき、投稿した名刺の情報が含まれている' do
      get card_path card.id
      expect(response.status).to eq 200
      expect(response.body).to include(card.s_last_name)
    end
  end

  describe 'GET /cards/search #search' do
  let!(:card) { FactoryBot.create(:card) }
  let!(:card_another) { FactoryBot.create(:card) }
    context '存在する名刺を検索したとき' do
      it 'HTTPステータスコード200が返され、名刺がレスポンスに含まれる' do
        get search_cards_path, params: { keyword: card.s_last_name }
        expect(response.status).to eq 200
        expect(response.body).to include(card.s_last_name)
        expect(response.body).not_to include(card_another.s_last_name)
      end
    end
    context '存在しない名刺を検索したとき' do
      it 'HTTPステータスコード200が返され、名刺がレスポンスに含まれない' do
        get search_cards_path, params: { keyword: 'kawai' }
        expect(response.status).to eq 200
        expect(response.body).not_to include(card.s_last_name)
        expect(response.body).not_to include(card_another.s_last_name)
      end
    end
    context '空で検索したとき' do
      it 'HTTPステータスコード200が返され、投稿されている名刺全てが表示される' do
        get search_cards_path, params: { keyword: '' }
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /cards #create' do
  let!(:card) { FactoryBot.create(:card) }
  let(:card_post) { FactoryBot.attributes_for(:card) }
  let(:card_without_name) { FactoryBot.attributes_for(:card, s_last_name: '') } 
  subject { post cards_path, params: { card: card_type } }
    context '名刺投稿者がアクセスしたとき' do
    before do
      sign_in_request(card.user)
    end
      context '名刺登録に必要な情報を全て入力したとき' do 
        let(:card_type) { card_post }
        it '名刺がデータベースに登録され、トップページにリダイレクトされる' do
          expect{ subject }.to change { Card.count }.by(1)
          expect(response).to redirect_to root_path
        end
      end
      context '名刺登録に必要な情報を入力しなかったとき' do
        let(:card_type) { card_without_name }
        it '名刺がデータベースに登録されず、エラーメッセージが表示される' do
          expect{ subject }.to change { Card.count }.by(0)
          expect(response.body).to include('姓を入力してください') 
        end
      end
    end
    context '未ログインユーザーがアクセスするとき' do 
      let(:card_type) { card_post }
      it '名刺がデータベースに登録されず、ログインページにリダイレクトされる' do
        expect{ subject }.to change { Card.count }.by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PUT /cards/:id #update' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card) }
  let(:card_post) { FactoryBot.attributes_for(:card) }
  let(:card_without_name) { FactoryBot.attributes_for(:card, s_last_name: '') } 
  subject { put card_path card.id, params: { card: card_type } }
    context '名刺投稿者がアクセスしたとき' do
    before do
      sign_in_request(card.user)
    end
      context '名刺編集に必要な情報を全て入力したとき' do 
      let(:card_type) { card_post }
        it '名刺が編集され、トップページにリダイレクトされる' do
          expect{ subject }.to change { Card.find(card.id).s_last_name }.from(card.s_last_name).to(card_post[:s_last_name]) 
          expect(response).to redirect_to root_path
        end
      end
      context '名刺編集に必要な情報を記入しないとき' do
      let(:card_type) { card_without_name }
        it '名刺が編集されず、エラーが表示される' do
          expect{ subject }.not_to change(Card.find(card.id), :s_last_name)
          expect(response.body).to include('姓を入力してください') 
        end
      end
    end
    context '名刺投稿者以外がアクセスするとき' do 
    let(:card_type) { card_post }
      it '名刺が変更されず、トップページにリダイレクトされる' do
        sign_in_request(user)
        expect{ subject }.not_to change(Card.find(card.id), :s_last_name)
        expect(response).to redirect_to root_path
      end
    end
    context '未ログインユーザーがアクセスするとき' do 
    let(:card_type) { card_post }
      it '名刺が変更されず、、ログインページにリダイレクトされる' do
        expect{ subject }.not_to change(Card.find(card.id), :s_last_name)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card) }
  subject { delete card_path card }
    context '名刺投稿者がアクセスしたとき' do
      it '名刺がデータベースから削除され、トップページにリダイレクトされる' do
        sign_in_request(card.user)
        expect{ subject }.to change { Card.count }.by(-1)
        expect(response).to redirect_to root_path
      end
    end
    context '名刺投稿者以外がアクセスするとき' do 
      it '名刺がデータベースから削除されず、トップページにリダイレクトされる' do
      sign_in_request(user)
      expect{ subject }.to change { Card.count }.by(0)
      expect(response).to redirect_to root_path
      end
    end
    context '未ログインユーザーがアクセスするとき' do 
      it '名刺がデータベースから削除されず、ログインページにリダイレクトされる' do
      expect{ subject }.to change { Card.count }.by(0)
      expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
