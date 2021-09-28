require 'rails_helper'

RSpec.describe "Users", type: :request do

  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.build(:user)
  end

  describe 'GET /users/sign_in registrations#new' do
    context '新規ユーザー登録画面' do
      it 'HTTPステータス200が返信される' do
        get '/users/sign_up'
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET /users/sign_up sessions#new' do
    context 'ユーザーログイン画面' do
      it 'HTTPステータス200が返信される' do
        get '/users/sign_in'
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /users/sign_up registrations#new' do
    context '新しくユーザー登録ができる' do
      it '必要な情報を全て入力し、トップページにアクセスできる' do
        expect{
        post "/users", params: {user: FactoryBot.attributes_for(:user)}
        }.to change(User, :count).by(1)
        expect(response.status).to redirect_to root_path
      end
    end
    context '新しくユーザー登録する時' do
      it '必要な情報を入力せず、そのままのページに残る' do
        expect{
          post "/users", params: {user: FactoryBot.attributes_for(:user, last_name:'')}
          }.to change(User, :count).by(0)
          expect(response.body).to include('姓を入力してください')
          expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /users/sign_in sessions#new' do
    context 'ユーザーサインインができる' do
      it '必要な情報を全て入力し、トップページにアクセスできる' do
        post "/users/sign_in", params: {user: @user1}
        expect(response.status).to eq 200
      end
    end
    context 'ユーザーサインインができない' do
      it '登録されていない情報を入力し、そのままのページに残る' do
        post "/users/sign_in", params: {user: @user2}
        expect(response.body).to include('Eメールまたはパスワードが違います')
      end
    end
  end

  describe 'GET /users/:id #show' do
    context '未登録ユーザーがアクセスした時' do 
      it 'トップページにリダイレクトされる' do
        get "/users/#{@user.id}"
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    context '登録済みユーザーがアクセスした時' do
      it '投稿した名刺とお気に入りした名刺が存在する' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @user.email, password: @user.password } }
        expect(response.status).to redirect_to root_path
        get "/users/#{@user.id}"
        expect(response.status).to eq 200
      end

    end
  end
end
