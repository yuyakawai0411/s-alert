class NoticeMailer < ApplicationMailer
  default from: "yasuo.hoklo.kappa@gmail.com"

  def send_mail(email,notice_date,description,topic,user_name)
    puts 'email sending...'
    @description = description
    @topic = topic
    @user = user_name
    mail(
      to:       email,
      from:     'yasuo.hoklo.kappa@gmail.com',
      subject:  "#{notice_date}(本日)の予定"
    ) 
  end

  def self.notice_mail
    @notices = Notice.all
    @notices.each do |notice|
      if notice.notice_date == Date.today
        email = notice.user.email
        notice_date = notice.notice_date
        description = notice.description
        topic = notice.topic
        user_name = notice.user.last_name
        NoticeMailer.send_mail(email,notice_date,description,topic,user_name).deliver_now
      end
    end
  end
end
