module RecordFillInSupport
  def record_fill_in_form(record)
    find("[data-testid='record-date']").set(record.date)
    find("[data-testid='record-phone-time']").select(record.phone_time.time)
    find("[data-testid='record-phone-call']").select(record.phone_call.status)
    find("[data-testid='record-expression']").select(record.expression.status)
  end

end