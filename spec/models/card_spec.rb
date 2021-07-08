require 'rails_helper'

RSpec.describe Card, type: :model do
  
  before do
    @card = FactoryBot.build(:card)
  end

  describe 'カード登録' do

    context 'カード登録できるとき' do
      it 's_last_name,s_first_name,s_last_name_kana,s_first_name_kana,s_company,s_company_form,s_department,s_phone_number,s_birth_day,use_idが存在すれば登録できる' do
       expect(@card).to be_valid
      end
      
      it '画像がなくても登録できる' do 
       @card.image = nil
       expect(@card).to be_valid
      end

      it 's_hobby_topがなくても登録できる' do 
        @card.s_hobby_top = ""
        expect(@card).to be_valid
       end

       it 's_hobby_mediumがなくても登録できる' do 
        @card.s_hobby_medium = ""
        expect(@card).to be_valid
       end

       it 's_hobby_rowがなくても登録できる' do 
        @card.s_hobby_row = ""
        expect(@card).to be_valid
       end

    end

    context 'カード登録できないとき' do
      it 's_last_nameが空では登録できない' do
        @card.s_last_name = ''
        @card.valid?
        expect(@card.errors.full_messages).to include "姓を入力してください"
      end

      it 's_first_nameが空では登録できない' do
        @card.s_first_name = ''
        @card.valid?
        expect(@card.errors.full_messages).to include "名を入力してください"
      end

      it 's_last_nameが漢字かなカタカナ以外では登録できない' do
        @card.s_last_name = 'aaa'
        @card.valid?
        expect(@card.errors.full_messages).to include "姓は全角文字を使用してください"
      end

      it 'first_nameが漢字かなカタカナ以外では登録できない' do
        @card.s_first_name = 'aaa'
        @card.valid?
        expect(@card.errors.full_messages).to include "名は全角文字を使用してください"
      end

      it 'last_name_kanaが空では登録できない' do
        @card.s_last_name_kana = ''
        @card.valid?
        expect(@card.errors.full_messages).to include "セイを入力してください"
      end

      it 'first_name_kanaが空では登録できない' do
        @card.s_first_name_kana = ''
        @card.valid?
        expect(@card.errors.full_messages).to include "メイを入力してください"
      end
      
      it 'last_name_kanaがカタカナ以外では登録できない' do
        @card.s_last_name_kana = '阿阿阿'
        @card.valid?
        expect(@card.errors.full_messages).to include "セイはカタカナ文字を使用してください"
      end

      it 'name_kanaがカタカナ以外では登録できない' do
        @card.s_first_name_kana = '阿阿阿'
        @card.valid?
        expect(@card.errors.full_messages).to include "メイはカタカナ文字を使用してください"
      end

      it 'companyが空では登録できない' do
        @card.s_company = ''
        @card.valid?
        expect(@card.errors.full_messages).to include "会社名を入力してください"
      end

      it '会社形態が未選択では登録できない' do
        @card.s_company_form_id = 0
        @card.valid?
        expect(@card.errors.full_messages).to include '会社形態は0以外の値にしてください'
      end
      
      it 'departmentが空では登録できない' do
        @card.s_department = ''
        @card.valid?
        expect(@card.errors.full_messages).to include "部署名を入力してください"
      end

      it 's_phone_numberが空では登録できない' do
        @card.s_phone_number = ''
        @card.valid?
        expect(@card.errors.full_messages).to include "携帯電話番号を入力してください"
      end

      it 's_birth_dayが空だと登録できない' do
        @card.s_birth_day = ''
        @card.valid?
        expect(@card.errors.full_messages).to include "誕生日を入力してください"
      end
    end
  end
end
