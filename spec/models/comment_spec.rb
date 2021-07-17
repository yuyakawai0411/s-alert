require 'rails_helper'

RSpec.describe "Comment", type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  
  describe '会話ネタ投稿' do

    context '会話ネタが投稿できるとき' do
      it 'テキストが存在すると登録できる' do
       expect(@comment).to be_valid
      end
    end

    context '会話ネタが投稿できないとき' do
      it 'テキストが空では登録できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include "テキストを入力してください"
      end
    end

  end
end
