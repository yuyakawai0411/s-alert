require 'rails_helper'

RSpec.describe "Notices", type: :request do

  describe 'GET /users/:user.id/notices #index' do
  let!(:notice) { FactoryBot.create(:notice) }
    context 'ログインユーザーがアクセスした時' do
      it 'HTTPステータスコード200が返され、通知一覧ページに移動する' do
        sign_in_request(notice.user)
        get "/users/#{notice.user.id}/notices"
        expect(response.status).to eq 200
      end
    end
    context '未ログインユーザーがアクセスした時' do
      it 'ログインページにリダイレクトされる' do
        get "/users/#{notice.user.id}/notices"
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST /users/:user_id/notices #create' do
  let!(:notice) { FactoryBot.create(:notice) }
  let(:notice_post) { FactoryBot.attributes_for(:notice) }
  subject { post "/users/#{notice.user.id}/notices", params: { notice: notice_post } }
    context 'ログインユーザーがアクセスした時' do
      it 'Noticeモデルのカウントが+1され、通知一覧ページにリダイレクトされる' do
        sign_in_request(notice.user)
        expect{ subject }.to change { Notice.count }.by(1)
        expect(response).to redirect_to "/users/#{notice.user.id}/notices"
      end
    end
    context '未ログインユーザーがアクセスした時' do
      it '通知情報が登録されず、ログインページにリダイレクトされる' do
        expect{ subject }.to change { Notice.count }.by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #destroy' do
  let!(:notice) { FactoryBot.create(:notice) }
  subject { delete "/users/#{notice.user.id}/notices/#{notice.id}", params: { id: notice.id, user_id: notice.user.id } }
    context 'ログインユーザーでアクセスした時' do
      it 'Noticeモデルのカウントが-1され、通知一覧ページに移動する' do
        sign_in_request(notice.user)
        expect{ subject }.to change { Notice.count }.by(-1)
        expect(response).to redirect_to "/users/#{notice.user.id}/notices"
      end
    end
    context '未ログインユーザーがアクセスした時' do
      it '通知情報が削除されず、ログインページにリダイレクトされる' do
        expect{ subject }.to change { Notice.count }.by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
