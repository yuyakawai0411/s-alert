require 'rails_helper'

RSpec.describe "Records", type: :request do

  describe 'GET /cards/:card.id/records #index' do
  let!(:user) {  FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card) }
    context '名刺投稿者がアクセスした時' do
      it 'HTTPステータスコード200が返され、着信登録ページに移動する' do
        sign_in_request(card.user)
        get "/cards/#{card.id}/records"
        expect(response.status).to eq 200
      end
    end
    context '名刺投稿者以外がアクセスした時' do
      it 'トップページにリダイレクトされる' do
        sign_in_request(user)
        get "/cards/#{card.id}/records"
        expect(response).to redirect_to root_path
      end
    end
    context '未ログインユーザーがアクセスした時' do
      it 'ログインページにリダイレクトされる' do
        get "/cards/#{card.id}/records"
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST /cards/:card.id/records #create' do
  let!(:user) {  FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card) }
  let(:record_post) { FactoryBot.attributes_for(:record) }
  let(:record_without_date) { FactoryBot.attributes_for(:record, date:'') }
  subject { post "/cards/#{card.id}/records", params: { record: record_type } }
    context '名刺刺投稿者がアクセスした時' do
    before do
      sign_in_request(card.user)
    end
      context '必須情報を全て入力したとき' do
      let(:record_type) { record_post }
        it 'Recordモデルのカウントが+1され、着信登録一覧ページにリダイレクトされる' do
          expect{ subject }.to change { Record.count }.by(1)
          expect(response).to redirect_to "/cards/#{card.id}/records"
        end
      end
      context '必須情報を全て入力しなかったとき' do
        let(:record_type) { record_without_date }
        it 'Recordモデルのカウントが変化せず、エラーメッセージが表示される' do
          expect{ subject }.to change { Record.count }.by(0)
          expect(response.body).to include('日付を入力してください')
        end
      end
    end
    context '名刺投稿者以外がアクセスした時' do
    let(:record_type) { record_post }
      it 'Recordモデルのカウントが変化せず、トップページにリダイレクトされる' do
        sign_in_request(user)
        expect{ subject }.to change { Record.count }.by(0)
        expect(response).to redirect_to root_path
      end
    end
    context '未ログインユーザーがアクセスした時' do
    let(:record_type) { record_post }
      it 'Recordモデルのカウントが変化せず、ログインページにリダイレクトされる' do
        expect{ subject }.to change { Record.count }.by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST /cards/:card_id/records/:id #destroy' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card) }
  let!(:record) { FactoryBot.create(:record, card_id: card.id) }
  subject { delete "/cards/#{record.card.id}/records/#{record.id}", params: { id: record.id, card_id: record.card.id } }
    context '名刺刺投稿者がアクセスした時' do
      it 'Recordモデルのカウントが-1され、着信登録一覧ページにリダイレクトされる' do
        sign_in_request(card.user)
        expect{ subject }.to change { Record.count }.by(-1)
        expect(response).to redirect_to "/cards/#{record.card.id}/records"
      end
    end
    context '名刺投稿者以外がアクセスした時' do
        it 'Recordモデルのカウントが変化せず、トップページにリダイレクトされる' do
          sign_in_request(user)
          expect{ subject }.to change { Record.count }.by(0)
          expect(response).to redirect_to root_path
        end
      end
      context '未ログインユーザーがアクセスした時' do
        it 'Recordモデルのカウントが変化せず、ログインページにリダイレクトされる' do
          expect{ subject }.to change { Record.count }.by(0)
          expect(response).to redirect_to new_user_session_path
        end
      end
  end

  describe 'POST /cards/:card_id/records/import #import' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card) }
  let(:csv_file) { fixture_file_upload('/phone_record.csv', 'text/csv') } #CSVファイルに3レコード存在する
  subject {  post "/cards/#{card.id}/records/import", params: { file: csv_file } }
    context '名刺投稿者本人がアクセスした時' do
      context 'csv_fileを登録するとき' do
        it 'Recordモデルのカウントが+3され、着信登録一覧ページにリダイレクトされる' do
          sign_in_request(card.user)
          expect{ subject }.to change { Record.count }.by(3) 
          expect(response).to redirect_to "/cards/#{card.id}/records" 
        end
      end
    end
    context '名刺投稿者以外がアクセスした時' do
      it 'Recordモデルのカウントが変化せず、トップページにリダイレクトされる' do
        sign_in_request(user)
        expect{ subject }.to change { Record.count }.by(0)
        expect(response).to redirect_to root_path
      end
    end
    context '未ログインユーザーがアクセスした時' do
      it 'Recordモデルのカウントが変化せず、ログインページにリダイレクトされる' do
        expect{ subject }.to change { Record.count }.by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
