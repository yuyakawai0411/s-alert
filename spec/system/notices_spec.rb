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
      fill_in 'notice_notice_date', with: @notice.notice_date
      fill_in 'notice_description', with: @notice.description
      fill_in 'notice_topic', with: @notice.topic
      find_by_id("notice-submit").click
      expect(current_path).to eq(user_notices_path(@user.id))
      # 設定した内容が存在する
      expect(page).to have_content @notice.notice_date
      expect(page).to have_content @notice.description
      expect(page).to have_content @notice.topic
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
