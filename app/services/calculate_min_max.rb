class CalculateMinMax

  def self.calculate_min(biorhythm) 
    if biorhythm.length < 3
      unstable_date = [["データが足りません",0],["データが足りません",0]]
    else
      unstable_date = biorhythm.min_by(2){|x,v| (v - 0).abs}
    end
    return unstable_date
  end

  def self.calculate_max(arrive_call) 
    if arrive_call.length < 3
      call_mode_day = [["データが足りません",0],["データが足りません",0]]
    else
      call_mode_day = arrive_call.max_by(2){|x,v| (v - 0).abs}
    end
    return call_mode_day
  end

end