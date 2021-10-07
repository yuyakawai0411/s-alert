require 'rails_helper'

RSpec.describe "ユーザー管理機能", type: :system do

  describe '新規ユーザー登録 divise#sign_up' do
    context '登録に必要な情報を全て入力した時' do 
    let(:user) { FactoryBot.build(:user) }
      it 'ユーザーが登録され、トップページに移動する' do
        # トップページに移動する
        visit root_path
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # 新規登録ページへ移動する
        visit new_user_registration_path
        # ユーザー情報を入力する
        user_fill_in_form(user)
        # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(1)
        # トップページへ遷移したことを確認する
        expect(current_path).to eq(root_path)
        # カーソルを合わせるとログアウトボタンが表示されることを確認する
        expect(page).to have_content('ログアウト')
      end
    end
    context 'ユーザー新規登録ができないとき' do
    let(:user) { FactoryBot.build(:user, last_name: '') }
      it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
        # トップページに移動する
        visit root_path
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # 新規登録ページへ移動する
        visit new_user_registration_path
        # ユーザー情報を入力する
        user_fill_in_form(user)
        # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
        # 新規登録ページへ戻されることを確認する
        expect(current_path).to eq('/users')
        # ルートパスに移動する
        visit root_path
        # ログインボタンがあることを確認
        expect(page).to have_content('ログイン')
        expect(page).to have_no_content('ログアウト')
      end
    end
  end

  describe 'ユーザーがログイン devise#sign_in' do
  let!(:user) { FactoryBot.create(:user) }
  let(:user_another) { FactoryBot.build(:user) }
    context '登録されているユーザー情報を入力した時' do
      it 'ログインができ、トップページに移動後、ログアウトが表示される' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # ログインページへ遷移する
        visit new_user_session_path
        # 正しいユーザー情報を入力する
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
        # ログインボタンを押す
        find('input[name="commit"]').click
        # トップページへ遷移することを確認する
        expect(current_path).to eq(root_path)
        # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_content('ログアウト')
      end
    end
    context '登録されていないユーザー情報を入力した時' do
      it 'ログインができず、トップページにログアウトが表示されている' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # ログインページへ遷移する
        visit new_user_session_path
        # ユーザー情報を入力する
        fill_in "user_email", with: user_another.email
        fill_in "user_password", with: user_another.password
        # ログインボタンを押す
        find('input[name="commit"]').click
        # ログインページへ戻されることを確認する
        expect(current_path).to eq(new_user_session_path)
        # ルートに戻る      
        visit root_path
        # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_no_content('ログアウト')
        expect(page).to have_content('ログイン')
      end
    end
  end

  describe 'ユーザーサインアウト devise#sign_out' do
  let!(:user) { FactoryBot.create(:user) }
    before do
      sign_in(user)
      expect(current_path).to eq(root_path)
    end
    it 'ログインができ、トップページに移動後、ログアウトが表示される' do
      # トップページに移動する
      expect(page).to have_content('ログアウト')
      # ログアウトボタンをクリックする
      click_link('ログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('ログアウト')
      expect(page).to have_content('ログイン')
    end
  end

  describe 'テストサインイン #test_sign_in' do
    context 'テストユーザーがデータベースに存在しない時' do
      it 'テストユーザーを作成し、トップページに移動後、ログアウトが表示される' do
        # トップページに移動する
        visit root_path
        expect(page).to have_content('ログイン')
        expect(page).to have_content('テストログイン')
        # テストログインボタンをクリックする
        expect{
          click_link('テストログイン')
        }.to change { User.count }.by(1)
        # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_content('ログアウト')
      end
    end
    context 'テストユーザーがデータベースに存在する時' do
      it 'テストユーザーを作成せず、トップページに移動後、ログアウトが表示される' do
        # トップページに移動する
        visit root_path
        # テストユーザーを作成する
        click_link('テストログイン')
        # ログアウトボタンをクリックする
        click_link('ログアウト')
        expect{
          click_link('テストログイン')
        }.to change { User.count }.by(0)
        # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_content('ログアウト')
      end
    end
  end

  describe 'ユーザー詳細 #show' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:card) { FactoryBot.create(:card, user_id: user.id) }
  let!(:card_another) { FactoryBot.create(:card) }
  let!(:favorite) { FactoryBot.create(:favorite, card_id: card_another.id, user_id: user.id) }
    context 'ユーザー詳細ページに移動したとき' do
      it 'ユーザーがお気に入りした名刺と投稿した名刺が表示される' do
        # トップページに移動する
        visit root_path
        # ログインする
        sign_in(user)
        # ユーザー詳細ページに移動する
        visit "/users/#{user.id}"
        # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
        card_exist_page(card_another)
        card_exist_page(card)
      end
    end
    context 'ユーザー詳細ページの「もっとみる」にアクセスする時' do
      it 'ユーザーが投稿した名刺が表示される' do
        # トップページに移動する
        visit root_path
        # ログインする
        sign_in(user)
        # ユーザー詳細ページに移動する
        visit "/users/#{user.id}"
        find_by_id('user-card-all').click
        # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
        expect(current_path).to eq(post_cards_user_path(user))
        card_exist_page(card)
      end
      it 'ユーザーがお気に入りした名刺が表示される' do
        # トップページに移動する
        visit root_path
        # ログインする
        sign_in(user)
        # ユーザー詳細ページに移動する
        visit "/users/#{user.id}"
        find_by_id('user-favorite-all').click
        # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
        expect(current_path).to eq(favorite_cards_user_path(user))
        card_exist_page(card_another)
      end
    end
  end

  describe 'ユーザー編集 #edit, update' do
  let!(:user) { FactoryBot.create(:user) }
  let(:user_post) { FactoryBot.build(:user) }
  let(:user_without_name) { FactoryBot.build(:user, last_name:'') }
    context 'ユーザー編集に必要な情報を全て入力する' do
      it 'ユーザー情報が更新される' do
        sign_in(user)
        # 編集ページへ遷移する
        visit edit_user_path(user)
        # 作成済みの内容が入力されている
        user_exist_form(user)
        # 名刺情報を編集する
        user_fill_in_form(user_post)
        # 編集してもCardモデルのカウントは変わらない
        expect{
          find_by_id('user-form-btn').click
        }.to change { User.count }.by(0)
        # 変更されたユーザー情報が存在する
        user_exist_page(user_post)
      end
    end
    context 'ユーザー編集に必要な情報を入力しない' do
      it 'ユーザー情報が更新されない' do
        sign_in(user)
        # 編集ページへ遷移する
        visit edit_user_path(user)
        # 作成済みの内容が入力されている
        user_exist_form(user)
        # 名刺情報を編集する
        user_fill_in_form(user_without_name)
        # 編集してもCardモデルのカウントは変わらない
        expect{
          find_by_id('user-form-btn').click
        }.to change { User.count }.by(0)
      end
    end
  end

  describe 'ユーザー削除 #destory' do
  let!(:user) { FactoryBot.create(:user) }
    it '登録したユーザーが削除される' do
      # トップページに移動する
      visit root_path
      # ログインする
      sign_in(user)
      # ユーザー詳細ページに移動する
      visit "/users/#{user.id}"
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect{
      click_link('削除')
      }.to change { User.count }.by(-1)
      # トップページに戻る
      expect(current_path).to eq(root_path)
      expect(page).to have_no_content('ログアウト')
      expect(page).to have_content('ログイン')
    end
  end


end

