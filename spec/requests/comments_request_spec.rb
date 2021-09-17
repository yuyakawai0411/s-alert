require 'rails_helper'

RSpec.describe "Comments", type: :request do
  
  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.build(:card)
  end

  describe 'POST #create' do
    context 'コメントができない' do 
      it '名刺詳細ページから移動しない' do
      
      end
    end

    context 'コメントができる' do
      
      it 'コメントとユーザー情報がインスタンスに格納される' do
      end

      it 'HTTP200ステータスコードが返される' do
      end

      it '名刺詳細ページから移動しない' do
      
      end
    end
  end

end
