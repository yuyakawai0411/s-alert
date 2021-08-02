class CardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :move_to_root, only: [:edit, :update, :destroy]
  before_action :side_menu, only: [:index, :new, :edit, :show, :search, :create, :update]
  before_action :set_comments, only: [:show]
  before_action :graph_range, only: [:show]
  before_action :set_biorhythm, only: [:show]

  def index
    # @cards = Card.order('created_at DESC')
    @cards = Card.page(params[:page]).per(3)
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    remove_card_blank
    if @card.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    remove_card_blank
    if @card.update(card_params)  
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to root_path
  end

  def search
    @cards = Card.search(params[:keyword])
  end

  def show
    records = @card.records
    arrive_call = records.where(phone_call_id: 1)
    
    # 手動で登録した感情を現在から過去2週間のグラフで表示
    @expression = records.where(
      date: [@today.prev_day(15),@today.prev_day(14),@today.prev_day(13),@today.prev_day(12),@today.prev_day(11),
      @today.prev_day(10),@today.prev_day(9),@today.prev_day(8),@today.prev_day(7),@today.prev_day(6),@today.prev_day(5),
      @today.prev_day(4),@today.prev_day(3),@today.prev_day(2),@today.prev_day(1),@today.prev_day(0)]).group(:date).sum(:expression_id)
    # バイオリズム理論値と縦軸の最大値、最小値を合わせる(縦軸の最小-1、最大1のグラフにする)
    if @expression.length < 2
      @expression = { @today.prev_day(15)=>0, @today=> 0 }
    else
      # 全てのvalueを絶対値にする
      expression_abs = @expression.map{ |x,y| [x, y.abs] }.to_h
      # 最大値を算出する
      expression_max = expression_abs.max{ |a,b| a[1] <=> b[1] }[1]
      # 0で割るケースは感情が全て0で登録された時のみのため、0を代入
      if expression_max == 0
        @expression = { @today.prev_day(15)=>0, @today=> 0 }
      else
        # 最大値でわる
        @expression = @expression.map{ |x,y| [x, (y.to_f / expression_max)] }.to_h
      end
    end

    # 過去の着信履歴から着信が多かった時間をグラフで表示
    @phone_time = arrive_call.group(:phone_time_id).count
    @phone_time = @phone_time.map{|k,v| [k.to_s + ":00" ,v]}.sort.to_h
    @phone_time_mode = @phone_time.max_by(2){|x,v| (v - 0).abs}
    if @phone_time.length < 2
      @phone_time = { "7:00"=>0, "21:00" => 0 }
      @phone_time_mode = [["データが足りません",0],["データが足りません",0]]
    end

    # 過去の着信履歴から着信が多かった曜日をグラフで表示
    weeks = []
    weeks_japanese = ["日", "月", "火", "水", "木", "金", "土"] 
    phone_weeks = arrive_call.pluck(:date)
    phone_weeks.each do |record|
      week = record.wday
      weeks << week
    end
    @phone_weeks = weeks.group_by{|x| x}.map{ |x,y| [x, y.count] }.sort.to_h
    @phone_weeks = @phone_weeks.map{|k,v| [weeks_japanese[k],v]}.to_h
    if @phone_weeks.length < 2
      @phone_weeks = { "月"=>0, "日" => 0 }
    end

  end


  private
  
  def card_params
    params.require(:card).permit(:image, :s_last_name, :s_first_name, :s_last_name_kana, :s_first_name_kana, 
      :s_company, :s_company_form_id, :s_department, :s_phone_number, :s_birth_day, :s_hobby_top, :s_hobby_medium, :s_hobby_row).merge(user_id: current_user.id)
  end

  def remove_card_blank
    @card[:s_last_name] = @card[:s_last_name].gsub(/[[:space:]]/, '')
    @card[:s_first_name] = @card[:s_first_name].gsub(/[[:space:]]/, '')
    @card[:s_last_name_kana] = @card[:s_last_name_kana].gsub(/[[:space:]]/, '')
    @card[:s_first_name_kana] = @card[:s_first_name_kana].gsub(/[[:space:]]/, '')
    @card[:s_phone_number] = @card[:s_phone_number].gsub(/-/,'')
  end

  def move_to_root
    unless @card.user.id == current_user.id
      redirect_to root_path
    end
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def side_menu
    if user_signed_in?
      @user = User.find(current_user.id)
      @user_cards = @user.cards
    end
  end

  def set_comments
    Comment.where("created_at < ?" , (Date.today-30)).delete_all
    @comment = Comment.new
    @comments = @card.comments.order(created_at: "DESC").includes(:user)
  end

  def graph_range
    @today = Date.today
    @prev15_day = @today.prev_day(15)
    @next15_day = @today.next_day(15)
  end

  def set_biorhythm
    # 登録された誕生日を元に、現在から前後2週間のバイオリズムグラフを作成
    pi = Math::PI
    birth_day = @card.s_birth_day
    delta = @today - birth_day
    @biorhythm_graph = {}
    i = -15

    30.times do 
      key = @today.next_day(i)
      value = Math.sin(2 * pi * (delta + i) / 28)
      @biorhythm_graph.store( "#{key}", value )
      i = i + 1
    end
    # バイオリズムグラフの中から不安定日(0に近い値)を2つ算出
    @unstable = @biorhythm_graph.min_by(2){|x,v| (v - 0).abs}
  end

end
