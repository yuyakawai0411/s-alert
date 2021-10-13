require 'rails_helper'
require 'date'

RSpec.describe "名刺機能", type: :system do

  describe '名刺一覧表示 #index' do
  let!(:card) { FactoryBot.create(:card) }
    it '名刺一覧ページに、投稿済みの名刺が存在する' do
      visit root_path
      card_exist_page(card)
    end
  end

  describe '名刺投稿 #new, #create' do
  let!(:user) { FactoryBot.create(:user) }
  let(:card_post) { FactoryBot.build(:card) }
  let(:card_without_name) { FactoryBot.build(:card, s_last_name:'') }
  let(:test_image) { Rails.root.join('public/images/test_image.png') }
    context '名刺投稿に必要な情報を全て入力するとき' do
      it '名刺が保存され、トップページに投稿した名刺が表示されている' do
        sign_in(user)
        # 新規作成のリンクがあることを確認する
        expect(page).to have_content('新規作成')
        # 新規作成ページに移動する
        visit new_card_path
        # 新規作成ページで必須情報を記入する
        card_fill_in_form(card_post, test_image)
        # 送信ボタンを押すと、Cardモデルのカウントが1上がる
        expect{
          find("[data-testid='card-submit']").click
          }.to change { Card.count }.by(1)
        # トップページに移動する
        expect(current_path).to eq(root_path)
        # トップページには先ほど作成した名刺が存在する
        card_exist_page(card_post)
      end
    end
    context '名刺投稿に必要な情報を入力しないとき' do
      it '名刺が保存されず、トップページに名刺が投稿されない' do
        sign_in(user)
        # 新規作成のリンクがあることを確認する
        expect(page).to have_content('新規作成')
        # 新規作成ページに移動する
        visit new_card_path
        # 新規作成ページで必須情報を記入する
        card_fill_in_form(card_without_name, test_image)
        # 送信ボタンを押しても、Cardモデルのカウントが上がらない
        expect{
          find("[data-testid='card-submit']").click
          }.to change { Card.count }.by(0)
        # トップページに移動しない
        expect(current_path).to eq("/cards")
      end
    end
  end

  describe '名刺編集 #edit, #update' do
  let!(:card) { FactoryBot.create(:card) }
  let(:card_post) { FactoryBot.build(:card) }
  let(:card_without_name) { FactoryBot.build(:card, s_last_name:'') }
  let(:test2_image) { Rails.root.join('public/images/test2_image.png') }
    context '名刺編集に必要な情報を全て入力するとき' do
      it '名刺の編集内容が反映され、トップページに編集後の名刺が存在する' do
        sign_in(card.user)
        # 編集ページへ遷移する
        visit edit_card_path(card)
        # 作成済みの内容が入力されている
        card_exist_form(card)
        # 名刺情報を編集する
        card_fill_in_form(card_post, test2_image)
        # 編集してもCardモデルのカウントは変わらない
        expect{
          find("[data-testid='card-submit']").click
        }.to change { Card.count }.by(0)
        # トップページに遷移する
        expect(current_path).to eq(root_path)
        # トップページには先ほど変更した内容が存在する
        expect(page).to have_selector("img[src$='test2_image.png']")
        card_exist_page(card_post)
      end
    end
    context '名刺編集に必要な情報を入力しないとき' do
      it '名刺の編集内容が反映されず、トップページに編集前の名刺が存在する' do
        sign_in(card.user)
        # 編集ページへ遷移する
        visit edit_card_path(card)
        # 作成済みの内容が入力されている
        card_exist_form(card)
        # 名刺情報を編集する
        card_fill_in_form(card_without_name, test2_image)
        # 編集してもCardモデルのカウントは変わらない
        expect{
          find("[data-testid='card-submit']").click
        }.to change { Card.count }.by(0)
        # トップページに移動しない
        expect(current_path).to eq("/cards/#{card.id}")
        # トップページに遷移する
        visit root_path
        # トップページには先ほど変更した内容が存在する
        expect(page).to have_selector("img[src$='test_image.png']")
        card_exist_page(card)
      end
    end
  end

  describe '名刺削除 #destroy' do
  let!(:card) { FactoryBot.create(:card) }
    context '名刺削除するとき' do
      it 'トップページから名刺が削除される' do
        sign_in(card.user)
        # 名刺が存在する
        card_exist_page(card)
        # 削除ボタンを押すとCardモデルのカウントが-1される
        expect{
          find("[data-testid='card-delete']").click
        }.to change { Card.count }.by(-1)
        # トップページに遷移する
        expect(current_path).to eq(root_path)
        # トップページに名刺が存在しない
        card_not_exist_page(card)
      end
    end
  end


  describe '名刺詳細 #show' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card) }
    context 'ログインユーザーがアクセスするとき' do
      it '名刺詳細ページにコメント投稿フォームが表示される' do
        # ログインする
        sign_in(user)
        # 詳細ページに移動する
        visit card_path(card)
        # 詳細ページに名刺情報が存在する
        expect(page).to have_selector("img[src$='test_image.png']")
        card_exist_page(card)
        # コメント投稿フォームが存在する
        expect(page).to have_selector '#comment_text'
      end
    end
    context '未ログインユーザーがアクセスするとき' do
      it '名刺詳細ページにコメント投稿フォームがが表示されない' do
        # トップページに移動する
        visit root_path
        # 詳細ページに移動する
        visit card_path(card)
        # 詳細ページに名刺情報が存在する
        expect(page).to have_selector("img[src$='test_image.png']")
        card_exist_page(card)
        # コメント投稿フォームが存在せず、「コメントの投稿には新規登録/ログインが必要です」と表示されている
        expect(page).to have_no_selector '#comment_text'
        expect(page).to have_content('コメントの投稿には新規登録/ログインが必要です。')
      end
    end
  end

  describe '名刺検索 #search' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:card1) { FactoryBot.create(:card, s_company_form_id: 1) }
  let!(:card2) { FactoryBot.create(:card, s_company_form_id: 3) }
    context '名刺1を検索するとき' do
      it '名刺1の検索結果を表示する' do
        # ログインする
        sign_in(user)
        # 名刺1が存在する
        card_exist_page(card1)
        # 名刺2が存在する
        card_exist_page(card2)
        # 名刺1を検索する
        find("[data-testid='keyword']").set(card1.s_company)
        find("[data-testid='search-btn']").click
        # 名刺1が表示されている
        card_exist_page(card1)
        # 名刺2は表示されていない
        card_not_exist_page(card2)
      end
    end
    context '存在しない名刺を検索するとき' do
      it '名刺を表示しない' do
        # ログインする
        sign_in(user)
        # 名刺1が存在する
        card_exist_page(card1)
        # 名刺2が存在する
        card_exist_page(card2)
        # 名刺1を検索する
        find("[data-testid='keyword']").set('@')
        find("[data-testid='search-btn']").click
        # 名刺1が表示されている
        card_not_exist_page(card1)
        # 名刺2は表示されていない
        card_not_exist_page(card2)
      end
    end
    context '空白で名刺を検索するとき' do
      it '全ての名刺を表示する' do
        # ログインする
        sign_in(user)
        # 名刺1が存在する
        card_exist_page(card1)
        # 名刺2が存在する
        card_exist_page(card2)
        # 空白で検索する
        find("[data-testid='keyword']").set('')
        find("[data-testid='search-btn']").click
        # 名刺1が表示されている
        card_exist_page(card1)
        # 名刺2が表示されている
        card_exist_page(card2)
      end
    end
  end
end


 

