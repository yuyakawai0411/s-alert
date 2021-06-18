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
      :s_company, :s_company_form_id, :s_department, :s_phone_number, :s_birth_day).merge(user_id: current_user.id)
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

end
