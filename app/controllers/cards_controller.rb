class CardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :card_info, only: [:show, :edit, :update, :destroy]
  before_action :unauthorized_user, only: [:edit, :update, :destroy]
  before_action :card_comments_info, only: [:show]
  before_action :side_menu, only: [:index, :new, :edit, :show, :search, :create, :update]

  def index
    @cards = Card.includes([:users, image_attachment: :blob]).page(params[:page]).per(9)
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
    @theoretical_biortythm_graph = DrawBiortythmGraph.theoretical_biortythm(@card.s_birth_day, -15, 0)
    @actual_biortythm_graph = DrawBiortythmGraph.actual_biortythm(@card.records, -15, 0)
    @arrive_call_time_graph = DrawCallGraph.arrive_call_time(@card.records)
    @arrive_call_week_graph = DrawCallGraph.arrive_call_week(@card.records)
    calculate_min_max
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

  def unauthorized_user
    unless @card.user.id == current_user.id
      redirect_to root_path
    end
  end

  def card_info
    @card = Card.find(params[:id])
  end
  
  def card_comments_info
    @comment = Comment.new
    @comments = @card.comments.order(created_at: "DESC").includes(:user)
  end

  def side_menu
    if user_signed_in?
      @user = User.find(current_user.id)
      @user_cards = @user.cards
    end
  end

  def calculate_min_max
    @unstable_day = CalculateMinMax.calculate_min(@theoretical_biortythm_graph)
    @call_time_mode_day = CalculateMinMax.calculate_max(@arrive_call_time_graph)
  end
end
