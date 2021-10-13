require 'rails_helper'
require 'date'

RSpec.describe "メール通知機能 #index", type: :system do
  describe 'メール通知の一覧が表示される' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:notice) { FactoryBot.create(:notice, user_id: user.id) }
    it '登録した通知一覧が表示される' do
      # ログインする
      sign_in(user)
      # メール通知に移動
      visit user_notices_path(user.id)
      #登録した通知情報が存在する
      notice_exist_page(notice)
    end
  end

  describe 'メール通知の登録を行う時 #create' do
    context 'メール通知に必要な情報を全て入力する時' do
    let!(:user) { FactoryBot.create(:user) }
    let(:notice) { FactoryBot.build(:notice) }
      it '登録した通知情報が表示されている' do
        # ログインする
        sign_in(user)
        # メール通知へのリンクがある
        expect(page).to have_link "メール通知", href: user_notices_path(user.id)
        # メール通知に移動
        visit user_notices_path(user.id)
        # メール通知情報を入力
        notice_fill_in_form(notice)
        expect{
          find("[data-testid='notice-submit']").click
        }.to change { Notice.count }.by(1)
        expect(current_path).to eq(user_notices_path(user.id))
        # 設定した内容が存在する
        notice_exist_page(notice)
      end
    end
    context 'メール通知に必要な情報を全て入力しない時' do
    let!(:user) { FactoryBot.create(:user) }
    let(:notice) { FactoryBot.build(:notice, notice_date: '') }
      it '登録しようとした通知が登録されない' do
        sign_in(user)
        # メール通知へのリンクがある
        expect(page).to have_link "メール通知", href: user_notices_path(user.id)
        # メール通知に移動
        visit user_notices_path(user.id)
        # メール通知情報を入力
        notice_fill_in_form(notice)
        expect{
          find("[data-testid='notice-submit']").click
        }.to change { Notice.count }.by(0)
        expect(current_path).to eq(user_notices_path(user.id))
      end
    end
  end

  describe 'メール通知の登録を行う時 #destory' do
    context 'メール通知に必要な情報を全て入力する時' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:notice) { FactoryBot.create(:notice, user_id: user.id) }
      it '登録した通知情報が表示されている' do
        # ログインする
        sign_in(user)
        # メール通知へのリンクがある
        expect(page).to have_link "メール通知", href: user_notices_path(user.id)
        # メール通知に移動
        visit user_notices_path(user.id)
        # 登録した通知情報が存在する
        notice_exist_page(notice)
        expect{
          find("[data-testid='notice-delete']").click
        }.to change { Notice.count }.by(-1)
        expect(current_path).to eq(user_notices_path(user.id))
        # 設定した内容が存在する
        notice_not_exist_page(notice)
      end
    end
  end
end