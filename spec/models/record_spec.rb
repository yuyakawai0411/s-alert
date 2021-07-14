require 'rails_helper'

RSpec.describe Record, type: :model do
  
  before do
    @record = FactoryBot.build(:record)
  end

  describe 'レコード登録' do

    context 'レコード登録できるとき' do
      it 'date,time,expressionが存在すると登録できる' do
       expect(@record).to be_valid
      end

      it 'expressionが0でも登録できる' do
        @record.expression_id = 0
        expect(@record).to be_valid
       end
    end

    context 'レコード登録できないとき' do
      it 'dateが空では登録できない' do
        @record.date = ''
        @record.valid?
        expect(@record.errors.full_messages).to include "日付を入力してください"
      end

      it 'phnoe_time_idが空では登録できない' do
        @record.phone_time_id = ""
        @record.valid?
        expect(@record.errors.full_messages).to include "時間は指定の範囲内で選択してください"
      end

      it 'phnoe_time_idが6時以下では登録できない' do
        @record.phone_time_id = 6
        @record.valid?
        expect(@record.errors.full_messages).to include "時間は指定の範囲内で選択してください"
      end

      it 'phnoe_time_idが23時以上では登録できない' do
        @record.phone_time_id = 23
        @record.valid?
        expect(@record.errors.full_messages).to include "時間は指定の範囲内で選択してください"
      end


      it 'expression_idが空では登録できない' do
        @record.expression_id = ""
        @record.valid?
        expect(@record.errors.full_messages).to include "感情は指定の範囲内で選択してください"
      end

      it 'expression_idが-4以下では登録できない' do
        @record.expression_id = -4
        @record.valid?
        expect(@record.errors.full_messages).to include "感情は指定の範囲内で選択してください"
      end

      it 'expression_idが4以上では登録できない' do
        @record.expression_id = 4
        @record.valid?
        expect(@record.errors.full_messages).to include "感情は指定の範囲内で選択してください"
      end
      it 'phoen_call_idが空では登録できない' do
        @record.phone_call_id = 0
        @record.valid?
        expect(@record.errors.full_messages).to include "着信有無を入力してください"
      end

    end
  end

end
