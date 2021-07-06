class RecordsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_card, only: [:index, :create, :destroy]
  before_action :move_to_root, only: [:create, :destroy]
  before_action :side_menu, only: [:index]

  def index
    @record = Record.new()
    @records = Record.order(date: :DESC)
  end

  def create
    @record = Record.new(record_params)
    @record.save
    redirect_to action: "index" 
  end


  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to action: "index"
  end

  private

  def record_params
    params.require(:record).permit(:date, :phone_time_id, :expression_id, :phone_call_id).merge(card_id: params[:card_id])
  end

  def set_card
    @card = Card.find(params[:card_id])
  end

  def move_to_root
    unless @card.user.id == current_user.id
      redirect_to root_path
    end
  end

  def side_menu
    if user_signed_in?
      @user = User.find(current_user.id)
      @user_cards = @user.cards
    end
  end
  
end
