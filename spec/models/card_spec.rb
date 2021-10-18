require 'rails_helper'

RSpec.describe Card, type: :model do  
  
  describe '名刺登録' do
  let(:card) { FactoryBot.build(:card) } 
    context '名刺登録できるとき' do
      it '必須事項が全て存在すれば登録できる' do
      expect(card).to be_valid
      end
      it '画像がなくても登録できる' do 
      card.image = nil
      expect(card).to be_valid
      end
      it '会話ネタ1がなくても登録できる' do 
        card.s_hobby_top = ""
        expect(card).to be_valid
      end
      it '会話ネタ2がなくても登録できる' do 
        card.s_hobby_medium = ""
        expect(card).to be_valid
      end
      it '会話ネタ3がなくても登録できる' do 
        card.s_hobby_row = ""
        expect(card).to be_valid
      end
    end
    context '名刺登録できないとき' do
    subject { card.errors.full_messages }
      it '姓が空では登録できない' do
        card.s_last_name = ''
        card.valid?
        is_expected.to include "姓を入力してください"
      end
      it '名が空では登録できない' do
        card.s_first_name = ''
        card.valid?
        is_expected.to include "名を入力してください"
      end
      it '姓が漢字かなカタカナ以外では登録できない' do
        card.s_last_name = 'aaa'
        card.valid?
        is_expected.to include "姓は全角文字を使用してください"
      end
      it '名が漢字かなカタカナ以外では登録できない' do
        card.s_first_name = 'aaa'
        card.valid?
        is_expected.to include "名は全角文字を使用してください"
      end
      it 'セイが空では登録できない' do
        card.s_last_name_kana = ''
        card.valid?
        is_expected.to include "セイを入力してください"
      end
      it 'メイが空では登録できない' do
        card.s_first_name_kana = ''
        card.valid?
        is_expected.to include "メイを入力してください"
      end
      it 'セイがカタカナ以外では登録できない' do
        card.s_last_name_kana = '阿阿阿'
        card.valid?
        is_expected.to include "セイはカタカナ文字を使用してください"
      end
      it 'メイがカタカナ以外では登録できない' do
        card.s_first_name_kana = '阿阿阿'
        card.valid?
        is_expected.to include "メイはカタカナ文字を使用してください"
      end
      it '社名が空では登録できない' do
        card.s_company = ''
        card.valid?
        is_expected.to include "会社名を入力してください"
      end
      it '会社形態が未選択では登録できない' do
        card.s_company_form_id = 0
        card.valid?
        is_expected.to include '会社形態を入力してください'
      end
      it '部署が空では登録できない' do
        card.s_department = ''
        card.valid?
        is_expected.to include "部署名を入力してください"
      end
      it '電話番号が空では登録できない' do
        card.s_phone_number = ''
        card.valid?
        is_expected.to include "携帯電話番号を入力してください"
      end
      it '誕生日が空だと登録できない' do
        card.s_birth_day = ''
        card.valid?
        is_expected.to include "誕生日を入力してください"
      end
    end
  end

  describe '名刺を削除する' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card, user_id: user.id) }
    it 'Records、Fvarites、Commentsテーブルの情報が付随して削除される' do
      2.times { FactoryBot.create(:record, card_id: card.id) }
      1.times { FactoryBot.create(:favorite, card_id: card.id, user_id: other_user.id) }
      2.times { FactoryBot.create(:comment, card_id: card.id) }
      expect{ card.destroy 
      }.to change(card.records, :count).by(-2).and change(card.favorites, :count).by(-1).and change(card.comments, :count).by(-2)
    end
  end
  
end
