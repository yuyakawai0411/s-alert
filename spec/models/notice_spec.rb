require 'rails_helper'

RSpec.describe Notice, type: :model do
  
  describe 'メール通知登録' do
    let(:notice) { FactoryBot.build(:notice) } 
    context 'メール通知が登録できるとき' do
      it '必須情報が全てが存在すると登録できる' do
       expect(notice).to be_valid
      end
      it '会話ネタが空でも登録できる' do
        notice.topic = ''
        expect(notice).to be_valid
      end
    end
    context 'メール通知が登録できないとき' do
      subject { notice.errors.full_messages }
      it '日時が空では登録できない' do
        notice.notice_date = ''
        notice.valid?
        is_expected.to include "日付は明日以降の日付を入力してください"
      end
      it '日時が過去では登録できない' do
        notice.notice_date = Date.today.prev_day(1)
        notice.valid?
        is_expected.to include "日付は明日以降の日付を入力してください"
      end
      it '内容が空では登録できない' do
        notice.description = ''
        notice.valid?
        is_expected.to include "内容を入力してください"
      end
    end
  end
end
