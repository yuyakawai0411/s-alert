require 'rails_helper'

RSpec.describe "Records", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.create(:card)
    @record = FactoryBot.create(:record)
  end

  describe 'GET /cards/:card.id/records #index' do
    context '未登録ユーザーがアクセスした時' do
      it 'トップページにリダイレクトされる' do
        get "/cards/#{@card.id}/records"
        expect(response).to redirect_to new_user_session_path
      end
    end
    context '登録ユーザーがアクセスした時' do
      it 'HTTPステータスコード200が返される' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @card.user.email, password: @card.user.password } }
        expect(response.status).to redirect_to root_path
        get "/cards/#{@card.id}/records"
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /cards/:card.id/records #create' do
    context '着信登録ができない' do
      it '着信登録ページにリダイレクトされる' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @card.user.email, password: @card.user.password } }
        expect(response.status).to redirect_to root_path
        expect{
        post "/cards/#{@card.id}/records", params: { record: FactoryBot.attributes_for(:record, date:'') }
        }.to change { Record.count }.by(0)
        expect(response.body).to include('日付を入力してください')
      end
    end

    context '着信登録ができる' do
      it '着信情報がインスタンスに格納される' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @card.user.email, password: @card.user.password } }
        expect(response.status).to redirect_to root_path
        expect{
        post "/cards/#{@card.id}/records", params: { record: FactoryBot.attributes_for(:record) }
        }.to change { Record.count }.by(1)
        expect(response).to redirect_to "/cards/#{@card.id}/records"
      end

    end
  end

  describe 'POST /cards/:card_id/records/:id #destroy' do
    context '着信情報が削除できる' do
      
      it 'インスタンスの名刺情報が空になる' do
        get new_user_session_path 
        post user_session_path, params: { user: { email: @record.card.user.email, password: @record.card.user.password } }
        expect(response.status).to redirect_to root_path
        expect{
        delete "/cards/#{@record.card.id}/records/#{@record.id}", params: { id: @record.id, card_id: @record.card.id }
        }.to change { Record.count }.by(-1)
        expect(response).to redirect_to "/cards/#{@record.card.id}/records"
      end
    end
  end

  describe 'POST #import' do
    context '着信情報が登録できない' do
      it '着信登録ページから移動しない' do
      
      end
    end
  
    context '着信情報が登録できる' do
      it 'HTTP200ステータスコードが返される' do
        
      end

      it '着信登録ページにリダイレクトされる' do
      
      end
    end
  end

end
