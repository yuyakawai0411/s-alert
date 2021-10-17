require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe 'POST /users/test_sign_in #show' do
    it 'テストユーザーでサインインされる' do
      post users_test_sign_in_path
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET /users/sign_in registrations#new' do
    it '新規ユーザーページに移動される' do
      get '/users/sign_up'
      expect(response.status).to eq 200
    end
  end

  describe 'GET /users/sign_up sessions#new' do
    it 'ログインページに移動される' do
      get '/users/sign_in'
      expect(response.status).to eq 200
    end
  end

  describe 'POST /users/sign_up registrations#new' do
  let(:user_post) { FactoryBot.attributes_for(:user) }
  let(:user_without_name) { FactoryBot.attributes_for(:user, last_name:'') }
  subject { post "/users", params: {user: user_type } }
    context '新規ユーザー登録に必要な情報すべてを入力した時' do
    let(:user_type) { user_post }
      it 'Userモデルのカウントが+1され、トップページにリダイレクトされる' do
        expect{ subject }.to change { User.count }.by(1)
        expect(response.status).to redirect_to root_path
      end
    end
    context '新しくユーザー登録する時' do
    let(:user_type) { user_without_name }
      it 'Userモデルのカウントが変化せず、エラーメッセージが表示される' do
        expect{ subject }.to change { User.count }.by(0)
        expect(response.status).to eq 200
        expect(response.body).to include('姓を入力してください')
      end
    end
  end

  describe 'POST /users/sign_in sessions#new' do
  let!(:user) { FactoryBot.create(:user) }
  let(:user_another) { FactoryBot.build(:user) }
    context '登録されているユーザーでログインするとき' do
      it 'HTTP200が返され、トップページにアクセスできる' do
        post "/users/sign_in", params: { user: user }
        expect(response.status).to eq 200
      end
    end
    context '登録されていないユーザーでログインするとき' do
      it 'エラーメッセージが表示される' do
        post "/users/sign_in", params: { user: user_another }
        expect(response.body).to include('Eメールまたはパスワードが違います')
      end
    end
  end

  describe 'GET /users/:id #show' do
  let!(:user) { FactoryBot.create(:user) }
    context 'ログインユーザーがアクセスした時' do
      it 'ユーザー詳細ページに移動する' do
        sign_in_request(user)
        get "/users/#{user.id}"
        expect(response.status).to eq 200
      end
    end
    context '未ログインユーザーがアクセスした時' do 
      it 'ログインページにリダイレクトされる' do
        get "/users/#{user.id}"
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'GET /users/:id/edit #edit' do
  let!(:user) { FactoryBot.create(:user) }
    context 'ログインユーザーがアクセスした時' do
      it 'ユーザー編集ページに移動し、ユーザー情報が存在する' do
        sign_in_request(user)
        get "/users/#{user.id}/edit"
        expect(response.status).to eq 200
        expect(response.body).to include(user.last_name)
      end
    end
    context '未ログインユーザーがアクセスした時' do
      it 'ログインページにリダイレクトされる' do
        get "/users/#{user.id}/edit"
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PUT /users/:id #update' do
  let!(:user) { FactoryBot.create(:user) }
  let(:user_post) { FactoryBot.attributes_for(:user) }
  let(:user_without_name) { FactoryBot.attributes_for(:user, last_name:'') }
  subject { put user_path user.id, params: { user: user_type, id: user.id } }
    context'ログインユーザーがアクセスした時' do
      before do
        sign_in_request(user)
      end
      context 'ユーザー編集に必要な情報を全て入力した時' do
      let(:user_type) { user_post }
        it 'ユーザー情報が更新され、ユーザー詳細ページにリダイレクトされる' do
          expect{ subject }.to change { User.find(user.id).last_name }.from(user.last_name).to(user_post[:last_name]) 
          expect(response).to redirect_to user_path user.id
        end
      end
      context 'ユーザー編集に必要な情報を入力しなかった時' do
      let(:user_type) { user_without_name }
        it 'ユーザー情報が更新されず、エラーメッセージが表示される' do
          expect{ subject }.not_to change(User.find(user.id), :last_name)
          expect(response.body).to include('姓を入力してください') 
        end
      end
    end
    context '未ログインユーザーがアクセスした時' do
    let(:user_type) { user_post }
      it 'ログインページにリダイレクトされる' do
        expect{ subject }.not_to change(User.find(user.id), :last_name)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
  let!(:user) { FactoryBot.create(:user) }
  subject { delete user_path user }
    context 'ログインユーザーがアクセスする時' do
      it 'Useモデルのカウントが-1され、トップページにリダイレクトされる' do
        sign_in_request(user)
        expect{ subject }.to change { User.count }.by(-1)
        expect(response).to redirect_to root_path
      end
    end
    context '未ログインユーザーがアクセスする時' do
      it 'Useモデルのカウントが-1され、トップページにリダイレクトされる' do
        expect{ subject }.to change { User.count }.by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /users/:id/post_cards #post_cards' do
  let!(:user) { FactoryBot.create(:user) }
    context 'ログインユーザーでアクセスするとき' do
      it '名刺投稿一覧ページにアクセスできる' do
        sign_in_request(user)
        get post_cards_user_path user
        expect(response.status).to eq 200
      end
    end
    context '未ログインユーザーでアクセスするとき' do
      it 'ログインページにリダイレクトされる' do
        get post_cards_user_path user
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /users/:id/favorite_cards #favorite_cards' do
  let!(:user) { FactoryBot.create(:user) }
    context 'ログインユーザーでアクセスするとき' do
      it 'お気に入り名刺一覧ページにアクセスできる' do
        sign_in_request(user)
        get favorite_cards_user_path user
        expect(response.status).to eq 200
      end
    end
    context '未ログインユーザーでアクセス' do
      it 'ログインページにリダイレクトされる' do
        get favorite_cards_user_path user
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
