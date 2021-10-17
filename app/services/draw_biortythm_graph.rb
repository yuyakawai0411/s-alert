class DrawBiortythmGraph < ApplicationRecord
  require 'date'

  def self.theoretical_biortythm(birth_day,minimum,maximum)
    minimum_day = Date.today.next_day(minimum)
    maximum_day = Date.today.prev_day(maximum)
    pi = Math::PI
    # 登録された誕生日を元に、現在から前後2週間のバイオリズムグラフを作成
    delta = maximum_day - birth_day
    biorhythm_graph = {}
    i = -15
    30.times do 
      key = maximum_day.next_day(i)
      value = Math.sin(2 * pi * (delta + i) / 28)
      biorhythm_graph.store( "#{key}", value )
      i = i + 1
    end
    return biorhythm_graph
  end

  def self.actual_biortythm(records,minimum,maximum)
    minimum_day = Date.today.next_day(minimum)
    maximum_day = Date.today.prev_day(maximum)
    # 手動で登録した感情を現在から過去2週間のグラフで表示
    expression = records.where(
      date: minimum_day..maximum_day).group(:date).sum(:expression_id)
      if expression.length < 3
        expression = { minimum_day=>0, maximum_day=> 0 }
      else
        # バイオリズム理論値と縦軸の最大値、最小値を合わせる(縦軸の最小-1、最大1のグラフにする)
        expression_abs = expression.map{ |x,y| [x, y.abs] }.to_h
        expression_max = expression_abs.max{ |a,b| a[1] <=> b[1] }[1]
        # 0で割るケースは感情が全て0で登録された時のみのため、0を代入
        if expression_max == 0
          expression = { minimum_day=>0, maximum_day=> 0 }
        else
          expression = expression.map{ |x,y| [x, (y.to_f / expression_max)] }.to_h
        end
    end
    return expression
  end

end