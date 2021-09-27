require 'rails_helper'

RSpec.describe "Notices", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @notice = FactoryBot.create(:notice)
  end

  describe 'GET /users/:user.id/notices #index' do
    context '未登録ユーザーがアクセスした時' do
      it 'トップページにリダイレクトされる' do
        get "/users/#{@notice.user.id}/notices"
        expect(response).to redirect_to new_user_session_path
      end
    end
    context '登録ユーザーがアクセスした時' do
      it 'HTTPステータスコード200が返される' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @notice.user.email, password: @notice.user.password } }
        expect(response.status).to redirect_to root_path
        get "/users/#{@notice.user.id}/notices"
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /users/:user_id/notices #create' do
    context '通知登録ができない' do
      it '通知登録ページにリダイレクトされる' do
        post "/users/#{@notice.user.id}/notices"
        expect(response).to redirect_to new_user_session_path
      end
    end

    context '通知登録ができる' do
      it '通知情報がインスタンスに格納される' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @notice.user.email, password: @notice.user.password } }
        expect(response.status).to redirect_to root_path
        expect{
        post "/users/#{@notice.user.id}/notices", params: { notice: FactoryBot.attributes_for(:notice) }
        }.to change { Notice.count }.by(1)
        expect(response).to redirect_to "/users/#{@notice.user.id}/notices"
      end
    end
  end

  describe 'POST #destroy' do
    context '通知情報が削除できる' do
      it 'インスタンスの通知情報が空になる' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @notice.user.email, password: @notice.user.password } }
        expect(response.status).to redirect_to root_path
        expect{
        delete "/users/#{@notice.user.id}/notices/#{@notice.id}", params: { id: @notice.id, user_id: @notice.user.id }
        }.to change { Notice.count }.by(-1)
        expect(response).to redirect_to "/users/#{@notice.user.id}/notices"
      end
    end
  end
end
