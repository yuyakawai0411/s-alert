require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    context '新規登録できるとき' do
      it 'email,password、password_confirmation,name,name_kana,company,company_form_id,descriptionが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Eメールはすでに存在します"
      end

      it 'emailに@が含まれていない場合登録できない' do
        @user.email = 'yuya.test1111gmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールは不正な値です"
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end

      it 'passwordが存在してもpassword_confirmationと同じでなければ登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '11aaa'
        @user.password_confirmation = '11aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは6文字以上で入力してください"
      end

      it 'passwordが数字のみの場合登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードには英字と数字の両方を含めて設定してください'
      end

      it 'passwordが半角英字のみの場合登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードには英字と数字の両方を含めて設定してください'
      end

      it 'passwordが全角では登録できない' do
        @user.password = '11aaaａ'
        @user.password_confirmation = '11aaaａ'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードには英字と数字の両方を含めて設定してください'
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "姓を入力してください"
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名を入力してください"
      end

      it 'last_nameが漢字かなカタカナ以外では登録できない' do
        @user.last_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "姓は全角文字を使用してください"
      end

      it 'first_nameが漢字かなカタカナ以外では登録できない' do
        @user.first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "名は全角文字を使用してください"
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "セイを入力してください"
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "メイを入力してください"
      end
      
      it 'last_name_kanaがカタカナ以外では登録できない' do
        @user.last_name_kana = '阿阿阿'
        @user.valid?
        expect(@user.errors.full_messages).to include "セイはカタカナ文字を使用してください"
      end

      it 'name_kanaがカタカナ以外では登録できない' do
        @user.first_name_kana = '阿阿阿'
        @user.valid?
        expect(@user.errors.full_messages).to include "メイはカタカナ文字を使用してください"
      end

      it 'companyが空では登録できない' do
        @user.company = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "会社名を入力してください"
      end

      it '会社形態が未選択では出品できない' do
        @user.company_form_id = 0
        @user.valid?
        expect(@user.errors.full_messages).to include '会社形態を入力してください'
      end
      
      it 'departmentが空では登録できない' do
        @user.department = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "部署名を入力してください"
      end

      it 'phone_numberが空では登録できない' do
        @user.phone_number = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "電話番号を入力してください"
      end

      it 'birth_dayが空では登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "誕生日を入力してください"
      end
    end
  end

end
