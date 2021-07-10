require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  
  describe 'コメント投稿' do

    context 'コメントが投稿できるとき' do
      it 'textが存在すると登録できる' do
       expect(@comment).to be_valid
      end
    end

    context 'コメントが投稿できないとき' do
      it 'textが空では登録できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include "テキストを入力してください"
      end
    end

  end
end
