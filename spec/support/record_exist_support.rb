module RecordExistSupport
  def record_exist_page(record)
    expect(find("[data-testid='record-list']")).to have_content(record.date)
    expect(find("[data-testid='record-list']")).to have_content(record.phone_time.time)
    expect(find("[data-testid='record-list']")).to have_content(record.expression.status)
  end

  def record_not_exist_page(record)
    expect(find("[data-testid='record-list']")).to have_no_content(record.date)
    expect(find("[data-testid='record-list']")).to have_no_content(record.phone_time.time)
    expect(find("[data-testid='record-list']")).to have_no_content(record.expression.status)
  end
end