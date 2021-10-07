module RecordExistSupport
  def record_exist_page(record)
    expect(page).to have_selector '.record-list-date', text: "#{record.date}"
    expect(page).to have_selector '.record-list-time', text: "#{record.phone_time.time}"
    expect(page).to have_selector '.record-list-expression', text: "#{record.expression.status}"
  end
  def record_not_exist_page(record)
    expect(page).to have_no_selector '.record-list-date', text: "#{record.date}"
    expect(page).to have_no_selector '.record-list-time', text: "#{record.phone_time_id}:00"
    expect(page).to have_no_selector '.record-list-expression', text: "#{record.expression.status}"
  end
end