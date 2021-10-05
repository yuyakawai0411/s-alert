module RecordFillInSupport
  def record_fill_in_form(record)
    fill_in "record[date]", with: record.date
    select "#{record.phone_time.time}", from: "record-phone-time"
    select "#{record.phone_call.status}", from: "record[phone_call_id]"
    select "#{record.expression.status}", from: "record[expression_id]"
  end

end