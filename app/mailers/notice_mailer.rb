class NoticeMailer < ApplicationMailer
  default from: "yasuo.hoklo.kappa@gmail.com"

  def send_mail
    puts "Helo"
    mail(
      to:      'yuya.scuba0411@gamil.com',
      from:     'yasuo.hoklo.kappa@gmail.com',
      subject: 'Mail from Message'
    ) 
  end

  def self.notice_mail
    NoticeMailer.send_mail.deliver_now
  end
end
