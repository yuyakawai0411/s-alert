module NoticeFillInSupport
  def notice_fill_in_form(notice)
    find("[data-testid='notice-date']").set(notice.notice_date)
    find("[data-testid='notice-description']").set(notice.description)
    find("[data-testid='notice-topic']").set(notice.topic)
  end
end