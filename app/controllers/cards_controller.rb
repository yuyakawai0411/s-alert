class CardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :move_to_root, only: [:edit, :update, :destroy]

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
      render :new
    end
  end

  def show
    today = Date.today
    @bio_reism = bio_risum_data
    records = @card.records.where(call_id: 1)
    @phone_time = records.group(:time_id).count
    @phone_date = records.where(
      date: [today.prev_day(15),today.prev_day(14),today.prev_day(13),today.prev_day(12),today.prev_day(11),
      today.prev_day(10),today.prev_day(9),today.prev_day(8),today.prev_day(7),today.prev_day(6),today.prev_day(5),
      today.prev_day(10),today.prev_day(9),today.prev_day(8),today.prev_day(7),today.prev_day(6),today.prev_day(5),
      today.prev_day(0),today.next_day(1),today.next_day(2),today.next_day(3),today.next_day(4),today.next_day(5),
      today.next_day(6),today.next_day(7),today.next_day(8),today.next_day(9),today.next_day(10),today.next_day(11),
      today.next_day(12),today.next_day(13),today.next_day(14),today.next_day(15)]
    ).group(:date).count
    @expression = records.group(:date).sum(:expression_id)
  
  end

  def edit

  end

  def update
    remove_card_blank
    if @card.update(card_params)  #card_paramsの中身が保存されるため、空白除去が効かない
      redirect_to card_path(@card.id)
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

  private
  
  def card_params
    params.require(:card).permit(:image, :s_last_name, :s_first_name, :s_last_name_kana, :s_first_name_kana, 
      :s_company, :s_company_form_id, :s_department, :s_phone_number, :s_birth_day, :s_hobby).merge(user_id: current_user.id)
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
    # 30.times do 
    #   bio_date = {}
    #   bio_date[:date] = today.next_day(i)
    #   bio_date[:value] = Math.sin(2 * pi * (delta + i) / 28)
    #   bio_reism << bio_date
    #   i = i + 1
    # end
    return bio_reism
  end

end
