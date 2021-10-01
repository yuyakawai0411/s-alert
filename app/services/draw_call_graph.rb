class DrawCallGraph < ApplicationRecord

  def self.arrive_call_time(records)
    call_time = records.where(phone_call_id: 1).group(:phone_time_id).count
    call_time = call_time.map{|k,v| [k.to_s + ":00" ,v]}.sort.to_h
    call_time_mode = call_time.max_by(2){|x,v| (v - 0).abs}
    if call_time.length < 2
      call_time = { "7:00"=>0, "21:00" => 0 }
      call_time_mode = [["データが足りません",0],["データが足りません",0]]
    end
    return call_time
  end

  def self.arrive_call_week(records)
    weeks = []
    weeks_japanese = ["日", "月", "火", "水", "木", "金", "土"] 
    call_week = records.where(phone_call_id: 1).pluck(:date)
    call_week.each do |record|
      week = record.wday
      weeks << week
    end
    call_week = weeks.group_by{|x| x}.map{ |x,y| [x, y.count] }.sort.to_h
    call_week = call_week.map{|k,v| [weeks_japanese[k],v]}.to_h
    if call_week.length < 2
      call_week = { "月"=>0, "日" => 0 }
    end
    return call_week
  end

end