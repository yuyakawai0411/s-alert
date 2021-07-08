require 'rails_helper'

RSpec.describe Notice, type: :model do
  
  before do
    @notice = FactoryBot.build(:notice)
  end
  
  describe '通話履歴登録' do

    context '通話履歴が登録できるとき' do
      it 'notice_date,description,topicが存在すると登録できる' do
       expect(@notice).to be_valid
      end
      it 'topicが空でも登録できる' do
        @notice.topic = ''
        expect(@notice).to be_valid
      end
    end

    context '通話履歴が登録できないとき' do
      it 'notice_dateが空では登録できない' do
        @notice.notice_date = ''
        @notice.valid?
        expect(@notice.errors.full_messages).to include "日付は明日以降の日付を入力してください"
      end

      it 'notice_dateが過去では登録できない' do
        @notice.notice_date = Date.today.prev_day(1)
        @notice.valid?
        expect(@notice.errors.full_messages).to include "日付は明日以降の日付を入力してください"
      end

      it 'descriptionが空では登録できない' do
        @notice.description = ''
        @notice.valid?
        expect(@notice.errors.full_messages).to include "内容を入力してください"
      end
    end
  end

end
