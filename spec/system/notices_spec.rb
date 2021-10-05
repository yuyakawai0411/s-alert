require 'rails_helper'
require 'date'

RSpec.describe "Notices", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @notice = FactoryBot.build(:notice)
  end

  context 'メール通知が設定できるとき' do
    it 'ログインユーザーはメール通知が設定できる' do
      # basic_pass root_path
      # ログインする
      sign_in(@user)
      # メール通知へのリンクがある
      expect(page).to have_link "メール通知", href: user_notices_path(@user.id)
      # メール通知に移動
      visit user_notices_path(@user.id)
      # メール通知情報を入力
      notice_fill_in_form(@notice)
      find_by_id("notice-submit").click
      expect(current_path).to eq(user_notices_path(@user.id))
      # 設定した内容が存在する
      notice_exist_page(@notice)
    end
  end

  context 'メール通知が設定できないとき' do
    it 'ログインしていないユーザーはメール通知が設定できない' do
      # トップページに遷移する
      visit root_path
      # メール通知へのリンクがない
      expect(page).to have_no_content('メール通知')
    end
  end  
end
