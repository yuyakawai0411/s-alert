require "rails_helper"

RSpec.describe NoticeMailer, type: :mailer do
  before do
    @user = FactoryBot.create(:user)
    @notice = FactoryBot.create(:notice, user_id: @user.id)
  end

  describe "メールの作成" do
    let(:mail) { NoticeMailer.send_mail(@user.email,@notice.notice_date,@notice.description,@notice.topic,@user.last_name) }

    it "メールの本文ができる" do
      expect(mail.subject).to eq("#{@notice.notice_date}(本日)の予定")
      expect(mail.to).to eq(["#{@user.email}"])
      expect(mail.from).to eq(["from@example.com"])
      expect(mail.cc).to eq(["yasuo.hoklo.kappa@gmail.com"])
      expect(mail.body.raw_source).to include("こんにちは#{@user.last_name}さん")
      expect(mail.body.raw_source).to include("#{@description}")
      expect(mail.body.raw_source).to include("#{@topic}")
    end
  end
end
