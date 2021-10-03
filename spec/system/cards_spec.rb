require 'rails_helper'
require 'date'

RSpec.describe "新規名刺作成", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.build(:card)
  end
  
  context '新規名刺作成ができるとき'do
    it 'ログインしたユーザーは新規作成できる' do
      # ログインする
      sign_in(@user)
      # 新規作成のリンクがあることを確認する
      expect(page).to have_content('新規作成')
      # 新規作成ページに移動する
      visit new_card_path
      # 新規作成ページで必須情報を記入する
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file("card_image", image_path)
      fill_in "card[s_last_name]", with: @card.s_last_name
      fill_in "card[s_first_name]", with: @card.s_first_name
      fill_in "card[s_last_name_kana]", with: @card.s_last_name_kana
      fill_in "card[s_first_name_kana]", with: @card.s_first_name_kana
      fill_in "card[s_company]", with: @card.s_company
      select "#{@card.s_company_form.form}", from: "card[s_company_form_id]"
      fill_in "card[s_department]", with: @card.s_department
      fill_in "card[s_phone_number]", with: @card.s_phone_number
      select "#{@card.s_birth_day.year}", from: "card[s_birth_day(1i)]"
      select "#{@card.s_birth_day.mon}", from: "card[s_birth_day(2i)]"
      select "#{@card.s_birth_day.mday}", from: "card[s_birth_day(3i)]"
      # 作成するとCardモデルのカウントが1上がる
      expect{
        find('input[name="commit"][id="card-new-create"]').click
        }.to change { Card.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページには先ほど作成した名刺が存在する
      expect(page).to have_selector('img[src$="test_image.png"]')
      card_exist(@card, 'yes')
    end
  end

  context '新規名刺作成ができないとき'do
    it 'ログインしていないユーザーは新規作成ページに遷移できない' do
      # トップページに移動する
      visit root_path
      # 新規作成のリンクがないことを確認する
      expect(page).to have_content('新規作成')
      # 投稿ページに移動する
      visit new_card_path
      # ログインページに戻される
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '名刺編集', type: :system do
  before do
    @card1 = FactoryBot.create(:card)
    @card2 = FactoryBot.create(:card)
    @card3 = FactoryBot.build(:card)
  end

  context '名刺編集ができるとき' do
    it '自分が作成した名刺の編集ができる' do
      # ログインする
      sign_in(@card1.user)
      # 編集リンクに投稿済みの名刺があることを確認する
      # expect(
      #   find_by_id("card-edit").click
      # ).to have_link("#{@card1.s_last_name}",href: edit_card_path(@card1))
      # 編集ページへ遷移する
      visit edit_card_path(@card1)
      # 作成済みの内容が入力されている
      expect(
        find('input[name="card[s_last_name]"]').value
      ).to eq(@card1.s_last_name)
      expect(
        find('input[name="card[s_first_name]"]').value
      ).to eq(@card1.s_first_name)
      expect(
        find('input[name="card[s_last_name_kana]"]').value
      ).to eq(@card1.s_last_name_kana)
      expect(
        find('input[name="card[s_first_name_kana]"]').value
      ).to eq(@card1.s_first_name_kana)
      expect(
        find('input[name="card[s_company]"]').value
      ).to eq(@card1.s_company)
      expect(
        find('select[name="card[s_company_form_id]"]').value
      ).to eq("#{@card1.s_company_form_id}")
      expect(
        find('input[name="card[s_department]"]').value
      ).to eq(@card1.s_department)
      expect(
        find('input[name="card[s_phone_number]"]').value
      ).to eq(@card1.s_phone_number)
      expect(
        find('select[name="card[s_birth_day(1i)]"]').value
      ).to eq("#{@card1.s_birth_day.year}")
      expect(
        find('select[name="card[s_birth_day(2i)]"]').value
      ).to eq("#{@card1.s_birth_day.mon}")
      expect(
        find('select[name="card[s_birth_day(3i)]"]').value
      ).to eq("#{@card1.s_birth_day.mday}")
      # 名刺情報を編集する
      image_path2 = Rails.root.join('public/images/test2_image.png')
      attach_file( "card_image", image_path2)
      fill_in "card[s_last_name]", with: @card3.s_last_name
      fill_in "card[s_first_name]", with: @card3.s_first_name
      fill_in "card[s_last_name_kana]", with: @card3.s_last_name_kana
      fill_in "card[s_first_name_kana]", with: @card3.s_first_name_kana
      fill_in "card[s_company]", with: @card3.s_company
      select "#{@card3.s_company_form.form}", from: "card[s_company_form_id]"
      fill_in "card[s_department]", with: @card3.s_department
      fill_in "card[s_phone_number]", with: @card3.s_phone_number
      select "#{@card3.s_birth_day.year}", from: "card[s_birth_day(1i)]"
      select "#{@card3.s_birth_day.mon}", from: "card[s_birth_day(2i)]"
      select "#{@card3.s_birth_day.mday}", from: "card[s_birth_day(3i)]"
      # 編集してもCardモデルのカウントは変わらない
      expect{
        find('input[name="commit"][id="card-new-create"]').click
      }.to change { Card.count }.by(0)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページには先ほど変更した内容が存在する
      expect(page).to have_selector("img[src$='test2_image.png']")
      card_exist(@card3, 'yes')
    end
  end

  context '名刺編集ができないとき' do
    it '他者が作成した名刺は編集できない' do
      # ログインする
      sign_in(@card1.user)
      # 編集リンクに他者が投稿した名刺がない
      # expect(
      #   find_by_id("card-edit").click
      # ).to have_link("#{@card1.s_last_name}",href: edit_card_path(@card1)).and have_no_link("#{@card2.s_last_name}",href: edit_card_path(@card2))
      # 他者の編集ページに移動しようとしてもトップページに戻される
      visit edit_card_path(@card2)
      expect(current_path).to eq(root_path)
    end
    it 'ログインしていないユーザーは名刺を編集できない' do
      # トップページに移動する
      visit root_path
      # 編集リンクに名刺がない
      # expect(
      #   find_by_id("card-edit").click
      # ).to have_no_link("#{@card1.s_last_name}",href: edit_card_path(@card1)).and have_no_link("#{@card2.s_last_name}",href: edit_card_path(@card2))
      # 編集ページに移動しようとしてもトップページに戻される
      visit edit_card_path(@card1)
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '名刺詳細', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.create(:card)
  end

  it 'ログインユーザーには、詳細ページにコメント投稿フォームが表示される' do
    # ログインする
    sign_in(@card.user)
    # 詳細ページに移動する
    visit card_path(@card)
    # 詳細ページに名刺情報が存在する
    expect(page).to have_selector("img[src$='test_image.png']")
    card_exist(@card, 'yes')
    # コメント投稿フォームが存在する
    expect(page).to have_selector '#comment_text'
  end

  it 'ログインしていないユーザーには、詳細ページにコメント投稿フォームがが表示されない' do
    # トップページに移動する
    visit root_path
    # 詳細ページに移動する
    visit card_path(@card)
    # 詳細ページに名刺情報が存在する
    expect(page).to have_selector("img[src$='test_image.png']")
    card_exist(@card, 'yes')
    # コメント投稿フォームが存在せず、「コメントの投稿には新規登録/ログインが必要です」と表示されている
    expect(page).to have_no_selector '#comment_text'
    expect(page).to have_content('コメントの投稿には新規登録/ログインが必要です。')
  end
end

RSpec.describe '名刺検索', type: :system do
  before do
    @card1 = FactoryBot.create(:card, s_company_form_id: 1)
    @card2 = FactoryBot.create(:card, s_company_form_id: 3)
  end

  it '名刺の検索結果を表示する' do
    # ログインする
    sign_in(@card1.user)
    # 名刺1が存在する
    card_exist(@card1, 'yes')
    # 名刺2が存在する
    card_exist(@card2, 'yes')
    # 名刺1を検索する
    fill_in 'keyword', with: @card1.s_company
    find_by_id('search-btn').click
    # 名刺1が表示されている
    card_exist(@card1, 'yes')
    # 名刺2は表示されていない
    card_exist(@card2, 'no')
  end

  it '空白だと名刺の検索結果を表示しない' do
    # ログインする
    sign_in(@card1.user)
    # 名刺1が存在する
    card_exist(@card1, 'yes')
    # 名刺2が存在する
    card_exist(@card2, 'yes')
    # 空白で検索する
    fill_in 'keyword', with: ""
    find_by_id('search-btn').click
    # 名刺1が表示されている
    card_exist(@card1, 'yes')
    # 名刺2が表示されている
    card_exist(@card2, 'yes')
  end
end

