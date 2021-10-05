require 'rails_helper'

RSpec.describe "着信タイミング登録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.create(:card)
    @record = FactoryBot.build(:record)
  end

  context '着信履歴の登録ができるとき' do 
    it '自分の名刺には着信履歴の登録ができる' do
      # ログイン
      # basic_pass root_path
      sign_in(@card.user)
      # トップページに投稿した名刺への作成&編集へのリンクがある
      # expect(
      #   find_by_id("record-edit").click
      # ).to have_link("#{@card.s_last_name}", href: card_records_path(@card))
      # 作成&編集ページへ移動する
      visit card_records_path(@card)
      # 必須情報を入力し、送信するとRecordのカウントが1上がる
      record_fill_in_form(@record)
      expect{
      find_by_id('record-submit').click
      }.to change { Record.count }.by(1)
      # 登録した着信履歴があるか確認
      expect(current_path).to eq(card_records_path(@card))
      record_exist_page(@record)
    end
  end

  context 'レコードの登録ができないとき' do
    it '異なるユーザーではレコードを登録できない' do
      # ログイン
      sign_in(@user)
      # トップページに投稿した名刺への作成&編集へのリンクがない
      # expect(
      #   find_by_id("record-edit").click
      # ).to have_no_link("#{@card.s_last_name}:00", href: card_records_path(@card))
    end
    it 'ログインしていないユーザーはレコードを登録できない' do
      visit root_path
      # トップページに投稿した名刺への作成&編集へのリンクがない
      # expect(
      #   find_by_id("record-edit").click
      # ).to have_no_link("#{@card.s_last_name}", href: card_records_path(@card))
    end
  end
end

RSpec.describe "着信履歴削除", type: :system do
  before do
    @card = FactoryBot.create(:card)
    @record = FactoryBot.build(:record)
  end

    it '削除リンクを押すと投稿を削除できる' do
      # トップページに移動する
      sign_in(@card.user)
      # トップページに投稿した名刺への作成&編集へのリンクがある
      # expect(
      #   find_by_id("record-edit").click
      # ).to have_link("#{@card.s_last_name}", href: card_records_path(@card))
      # 作成&編集ページへ移動する
      visit card_records_path(@card)
      # 必須情報を入力し、送信するとRecordのカウントが1上がる
      record_fill_in_form(@record)
      expect{
      find_by_id('record-submit').click
      }.to change { Record.count }.by(1)
      # 登録した着信履歴があるか確認
      expect(current_path).to eq(card_records_path(@card))
      record_exist_page(@record)
      # 着信履歴の削除をクリック
      first(".record-delete").click
      # 登録した着信履歴が消えている
      expect(current_path).to eq(card_records_path(@card))
      record_not_exist_page(@record)
    end
end

RSpec.describe "CSVインポート", type: :system do
  before do
    @card = FactoryBot.create(:card)
  end

    it 'csvをインポートして着信履歴を登録できる' do
      # トップページに移動する
      sign_in(@card.user)
      # トップページに投稿した名刺への作成&編集へのリンクがある
      # expect(
      #   find_by_id("record-edit").click
      # ).to have_link("#{@card.s_last_name}", href: card_records_path(@card))
      # 作成&編集ページへ移動する
      visit card_records_path(@card)
      # CSVのファイルをアップロード
      csv_path = Rails.root.join('db/csv/phone_record.csv')
      attach_file("file", csv_path)
      find('#csv-submit').click
      expect(current_path).to eq(card_records_path(@card))
 
      # アップロードした情報があるか確認
      expect(current_path).to eq(card_records_path(@card))
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