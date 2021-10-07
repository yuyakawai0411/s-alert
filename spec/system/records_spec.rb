require 'rails_helper'

RSpec.describe "着信履歴機能", type: :system do

  describe '着信履歴を一覧表示するとき #index' do 
  let(:card) { FactoryBot.create(:card) }
  let!(:record) { FactoryBot.create(:record, card_id: card.id) }
    it '登録済みの着信履歴が一覧で表示される' do
      # ログイン
      sign_in(card.user)
      # 作成&編集ページへ移動する
      visit card_records_path(card)
      # 登録した着信履歴があるか確認
      expect(current_path).to eq(card_records_path(card))
      record_exist_page(record)
    end
  end

  describe '着信履歴を登録するとき #create' do
  let!(:card) { FactoryBot.create(:card) }
    context '着信履歴に必要な情報を全て入力するとき' do 
    let(:record) { FactoryBot.build(:record) }
      it '自分の名刺には着信履歴の登録ができる' do
        # ログイン
        sign_in(card.user)
        # 作成&編集ページへ移動する
        visit card_records_path(card)
        # 必須情報を入力し、送信するとRecordのカウントが1上がる
        record_fill_in_form(record)
        expect{
        find_by_id('record-submit').click
        }.to change { Record.count }.by(1)
        # 登録した着信履歴があるか確認
        expect(current_path).to eq(card_records_path(card))
        record_exist_page(record)
      end
    end
    context '着信履歴に必要な情報を全て入力するとき' do 
    let(:record) { FactoryBot.build(:record, date:'') }
      it '自分の名刺には着信履歴の登録ができる' do
        # ログイン
        sign_in(card.user)
        # 作成&編集ページへ移動する
        visit card_records_path(card)
        # 必須情報を入力し、送信するとRecordのカウントが1上がる
        record_fill_in_form(record)
        expect{
        find_by_id('record-submit').click
        }.to change { Record.count }.by(0)
        # 登録した着信履歴があるか確認
        expect(current_path).to eq(card_records_path(card))
      end
    end
  end

  describe '着信履歴を削除するとき #destroy' do
  let!(:card) { FactoryBot.create(:card) }
  let!(:record) { FactoryBot.create(:record, card_id: card.id) }
    it '削除リンクを押すと投稿を削除できる' do
      # トップページに移動する
      sign_in(card.user)
      # 作成&編集ページへ移動する
      visit card_records_path(card)
      # 登録した着信履歴があるか確認
      record_exist_page(record)
      # 削除リンクをクリックするとRecordのカウントが1上がる
      expect{
        first(".record-delete").click
      }.to change { Record.count }.by(-1)
      expect(current_path).to eq(card_records_path(card))
      # 登録した着信履歴が消えている
      record_not_exist_page(record)
    end
  end

  describe '着信履歴をインポートする' do
  let!(:card) { FactoryBot.create(:card) }
    it 'csvをインポートして着信履歴を登録できる' do
      # トップページに移動する
      sign_in(card.user)
      # 作成&編集ページへ移動する
      visit card_records_path(card)
      # CSVのファイルをアップロード
      csv_path = Rails.root.join('db/csv/phone_record.csv')
      attach_file("file", csv_path)
      find('#csv-submit').click
      expect(current_path).to eq(card_records_path(card))
      # アップロードした情報があるか確認
      expect(current_path).to eq(card_records_path(card))
      expect(page).to have_selector '.record-list-date', text: "2021-07-18"
      expect(page).to have_selector '.record-list-time', text: "11:00"
      expect(page).to have_selector '.record-list-expression', text: '---'
    
      expect(page).to have_selector '.record-list-date', text: "2021-07-28"
      expect(page).to have_selector '.record-list-time', text: "10:00"
      expect(page).to have_selector '.record-list-expression', text: '---'
    
      expect(page).to have_selector '.record-list-date', text: "2021-08-21"
      expect(page).to have_selector '.record-list-time', text: "13:00"
      expect(page).to have_selector '.record-list-expression', text: '---'
    end
  end
end