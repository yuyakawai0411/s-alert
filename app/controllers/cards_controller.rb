class CardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :move_to_root, only: [:edit, :update, :destroy]
  before_action :side_menu, only: [:index, :new, :edit, :show, :search]
  before_action :bio_risum_data, only: [:show]
  before_action :set_comments, only: [:show]


  def index
    @cards = Card.order('created_at DESC')
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
      side_menu
      render :new
    end
  end

  def show
    today = Date.today
    @today = Date.today
    @prev15_day = today.prev_day(15)
    @next15_day = today.next_day(15)


    records = @card.records.where(phone_call_id: 1)
    
    # 着信時間グラフ及び最頻値の表示
    @phone_time = records.group(:phone_time_id).count
    @phone_time = @phone_time.map{|k,v| [k.to_s + ":00" ,v]}.to_h
    @phone_time_mode = @phone_time.max_by(2){|x,v| (v - 0).abs}
      if @phone_time.length < 2
        @phone_time = { "7:00"=>0, "21:00" => 0 }
        @phone_time_mode = [["データが足りません",0],["データが足りません",0]]
      end

    #感情グラフの表示
    @expression = records.where(
      date: [today.prev_day(15),today.prev_day(14),today.prev_day(13),today.prev_day(12),today.prev_day(11),
      today.prev_day(10),today.prev_day(9),today.prev_day(8),today.prev_day(7),today.prev_day(6),today.prev_day(5),
      today.prev_day(4),today.prev_day(3),today.prev_day(2),today.prev_day(1),today.prev_day(0)]).group(:date).sum(:expression_id)
      if @expression.length < 2
        @expression = { today.prev_day(15)=>0, today=> 0 }
      end

    # 着信曜日グラフの表示
    weeks = []
    weeks_japanese = ["日", "月", "火", "水", "木", "金", "土"] 
    phone_weeks = records.pluck(:date)
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

  def edit

  end

  def update
    remove_card_blank
    if @card.update(card_params)  #card_paramsの中身が保存されるため、空白除去が効かない
      redirect_to card_path(@card.id)
    else
      side_menu
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

  def bio_risum_data
    pi = Math::PI
    birth_day = @card.s_birth_day
    today = Date.today  
    delta = today - birth_day
    bio_reism = {}
    i = -15

    30.times do 
      key = today.next_day(i)
      value = Math.sin(2 * pi * (delta + i) / 28)
      bio_reism.store( "#{key}", value )
      i = i + 1
    end
    @bio_reism = bio_reism
    @bad_date = @bio_reism.min_by(2){|x,v| (v - 0).abs}
  end

  def set_comments
    Comment.where("created_at < ?" , (Date.today-30)).delete_all
    @comment = Comment.new
    @comments = @card.comments.order(created_at: "DESC").includes(:user)
  end

end
