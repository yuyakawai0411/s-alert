require 'rails_helper'

RSpec.describe Record, type: :model do
  
  before do
    @record = FactoryBot.build(:record)
  end

  describe '着信履歴登録' do

    context '着信履歴登録できるとき' do
      it '必須情報が全て存在すると登録できる' do
       expect(@record).to be_valid
      end

      it '感情が未選択でも登録できる' do
        @record.expression_id = 0
        expect(@record).to be_valid
       end
    end

    context '着信履歴登録できないとき' do
      it '日付が空では登録できない' do
        @record.date = ''
        @record.valid?
        expect(@record.errors.full_messages).to include "日付を入力してください"
      end

      it '時間が空では登録できない' do
        @record.phone_time_id = ""
        @record.valid?
        expect(@record.errors.full_messages).to include "時間は指定の範囲内で選択してください"
      end

      it '時間が6時以下では登録できない' do
        @record.phone_time_id = 6
        @record.valid?
        expect(@record.errors.full_messages).to include "時間は指定の範囲内で選択してください"
      end

      it '時間が23時以上では登録できない' do
        @record.phone_time_id = 23
        @record.valid?
        expect(@record.errors.full_messages).to include "時間は指定の範囲内で選択してください"
      end


      it '感情が空では登録できない' do
        @record.expression_id = ""
        @record.valid?
        expect(@record.errors.full_messages).to include "感情は指定の範囲内で選択してください"
      end

      it '感情が-4以下では登録できない' do
        @record.expression_id = -4
        @record.valid?
        expect(@record.errors.full_messages).to include "感情は指定の範囲内で選択してください"
      end

      it '感情が4以上では登録できない' do
        @record.expression_id = 4
        @record.valid?
        expect(@record.errors.full_messages).to include "感情は指定の範囲内で選択してください"
      end
      it '着信有無が空では登録できない' do
        @record.phone_call_id = 0
        @record.valid?
        expect(@record.errors.full_messages).to include "着信有無を入力してください"
      end

    end
  end

end
