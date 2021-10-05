module NoticeFillInSupport
  def notice_fill_in_form(notice)
    fill_in 'notice_notice_date', with: notice.notice_date
    fill_in 'notice_description', with: notice.description
    fill_in 'notice_topic', with: notice.topic
  end
end