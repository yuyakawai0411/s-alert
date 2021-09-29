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

  describe 'GET /users/:id/edit #edit' do
    context 'ユーザー編集画面にアクセスできる' do
      it 'HTTPステータス200が返信される' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @user.email, password: @user.password } }
        expect(response.status).to redirect_to root_path
        get "/users/#{@user.id}/edit"
        expect(response.status).to eq 200
        expect(response.body).to include(@user.last_name)
      end
    end

    context 'ユーザー編集画面にアクセスできない' do
      it '登録画面にリダイレクトされる' do
        get "/users/#{@user.id}/edit"
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PUT /users/:id #update' do
    context 'ユーザー編集ができる' do
      it '必要な情報を全て入力し、トップページにアクセスできる' do
        user_edit = FactoryBot.attributes_for(:user)
        get new_user_session_path 
        post user_session_path, params: { user: { email: @user.email, password: @user.password } }
        expect(response.status).to redirect_to root_path
        expect{
          put user_path @user.id, params: { user: user_edit, id: @user.id }
        }.to change { User.find(@user.id).last_name }.from(@user.last_name).to(user_edit[:last_name]) 
        expect(response).to redirect_to user_path @user.id
      end
    end

    context 'ユーザー編集ができない' do
      it '必要な情報を入力せず、そのままのページに残る' do
        user_edit = FactoryBot.attributes_for(:user, last_name:'')
        get new_user_session_path 
        post user_session_path, params: { user: { email: @user.email, password: @user.password } }
        expect(response.status).to redirect_to root_path
        expect{
          put user_path @user.id, params: { user: user_edit, id: @user.id }
        }.not_to change(User.find(@user.id), :last_name)
        expect(response.body).to include('姓を入力してください') 
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ユーザー削除できる' do
      it 'ユーザーが削除され、トップページにリダイレクトされる' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @user.email, password: @user.password } }
        expect(response.status).to redirect_to root_path
        expect{
          delete user_path @user
        }.to change(User, :count).by(-1)
        expect(response).to redirect_to root_path
      end
    end
  end


end
