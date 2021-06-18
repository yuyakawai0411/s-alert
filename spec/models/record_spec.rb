require 'rails_helper'

RSpec.describe Record, type: :model do
  
  before do
    @record = FactoryBot.build(:record)
  end

  describe 'レコード登録' do

    context 'レコード登録できるとき' do
      it 'phone_day,phone_time,expressionが存在すると登録できる' do
       expect(@record).to be_valid
      end

    end

    context 'レコード登録できないとき' do
      it 'phone_dayが空では登録できない' do
        @record.phone_day = ''
        @record.valid?
        expect(@record.errors.full_messages).to include "日付を入力してください"
      end

      it 'phnoe_time_idが空では登録できない' do
        @record.phone_time_id = 0
        @record.valid?
        expect(@record.errors.full_messages).to include "時間は0以外の値にしてください"
      end

      it 'expression_idが空では登録できない' do
        @record.expression_id = 0
        @record.valid?
        expect(@record.errors.full_messages).to include "感情は0以外の値にしてください"
      end

    end
  end

end
