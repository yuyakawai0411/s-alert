require "rails_helper"

RSpec.describe NoticeMailer, type: :mailer do

  describe "メールが送信される時" do
  let!(:user) { FactoryBot.create(:user) }
  let!(:notice) { FactoryBot.create(:notice, user_id: user.id) }
  let(:mail) { NoticeMailer.send_mail(user.email,notice.notice_date,notice.description,notice.topic,user.last_name) }
    it "メールに正しい宛先、題名、本文が入力される" do
      expect(mail.subject).to eq("#{notice.notice_date}(本日)の予定")
      expect(mail.to).to eq(["#{user.email}"])
      expect(mail.from).to eq(["from@example.com"])
      expect(mail.cc).to eq(["yasuo.hoklo.kappa@gmail.com"])
      expect(mail.body.raw_source).to include("こんにちは#{user.last_name}さん")
      expect(mail.body.raw_source).to include("#{@description}")
      expect(mail.body.raw_source).to include("#{@topic}")
    end
  end
end
