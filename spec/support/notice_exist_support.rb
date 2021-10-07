module NoticeExistSupport
  def notice_exist_page(notice)
    expect(page).to have_content notice.notice_date
    expect(page).to have_content notice.description
    expect(page).to have_content notice.topic
  end

  def notice_not_exist_page(notice)
    expect(page).to have_no_content notice.notice_date
    expect(page).to have_no_content notice.description
    expect(page).to have_no_content notice.topic
  end

end