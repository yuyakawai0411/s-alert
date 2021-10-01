require 'rails_helper'

RSpec.describe User, type: :model do  
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録できるとき' do
      it '必須情報が全て存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end

      it '重複しメールアドレスが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Eメールはすでに存在します"
      end

      it 'メールアドレスに@が含まれていない場合登録できない' do
        @user.email = 'yuya.test1111gmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールは不正な値です"
      end

      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end

      it 'パスワードが存在してもpassword_confirmationと同じでなければ登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end

      it 'パスワードが5文字以下では登録できない' do
        @user.password = '11aaa'
        @user.password_confirmation = '11aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは6文字以上で入力してください"
      end

      it 'パスワードが数字のみの場合登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードには英字と数字の両方を含めて設定してください'
      end

      it 'パスワードが半角英字のみの場合登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードには英字と数字の両方を含めて設定してください'
      end

      it 'パスワードが全角では登録できない' do
        @user.password = '11aaaａ'
        @user.password_confirmation = '11aaaａ'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードには英字と数字の両方を含めて設定してください'
      end

      it '姓が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "姓を入力してください"
      end

      it '名が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名を入力してください"
      end

      it '姓が漢字かなカタカナ以外では登録できない' do
        @user.last_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "姓は全角文字を使用してください"
      end

      it '名が漢字かなカタカナ以外では登録できない' do
        @user.first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "名は全角文字を使用してください"
      end

      it 'セイが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "セイを入力してください"
      end

      it 'メイが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "メイを入力してください"
      end
      
      it 'セイがカタカナ以外では登録できない' do
        @user.last_name_kana = '阿阿阿'
        @user.valid?
        expect(@user.errors.full_messages).to include "セイはカタカナ文字を使用してください"
      end

      it 'メイがカタカナ以外では登録できない' do
        @user.first_name_kana = '阿阿阿'
        @user.valid?
        expect(@user.errors.full_messages).to include "メイはカタカナ文字を使用してください"
      end

      it '会社名が空では登録できない' do
        @user.company = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "会社名を入力してください"
      end

      it '会社形態が未選択では出品できない' do
        @user.company_form_id = 0
        @user.valid?
        expect(@user.errors.full_messages).to include '会社形態を入力してください'
      end
      
      it '部署が空では登録できない' do
        @user.department = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "部署名を入力してください"
      end

      it '電話番号が空では登録できない' do
        @user.phone_number = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "電話番号を入力してください"
      end

      it '誕生日が空では登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "誕生日を入力してください"
      end
    end
  end

  describe 'ユーザーを削除する' do
    let(:user) { FactoryBot.create(:user) }
    let(:card) { FactoryBot.create(:card, user: user) }
    it 'Cards、Records、Fvarites、Commentsテーブルの情報が付随して削除される' do
      2.times { FactoryBot.create(:record, card: card) }
      1.times { FactoryBot.create(:favorite, card: card, user: user) }
      2.times { FactoryBot.create(:comment, card: card) }
      expect{ user.destroy 
      }.to change(user.cards, :count).by(-1).and change(card.records, :count).by(-2).and change(card.favorites, :count).by(-1).and change(card.comments, :count).by(-2)
    end
  end
end
