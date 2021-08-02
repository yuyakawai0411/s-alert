class RecordsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :import]
  before_action :set_card, only: [:index, :create, :destroy, :import, :biorhythm]
  before_action :move_to_root, only: [:create, :destroy, :import]
  before_action :side_menu, only: [:index, :create, :import, :biorhythm]

  def index
    @record = Record.new()
    @records = Record.order(date: :DESC)
  end

  def create
    @record = Record.new(record_params)
    @records = Record.order(date: :DESC)
    if @record.save
      redirect_to action: "index" 
    else
      render :index
    end
  end


  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to action: "index"
  end

  def import
    list = []
    card_id = @card.id
    if params[:file].blank? || (File.extname(params[:file].original_filename) != ".csv")
       redirect_to action: "index", alert: 'csvファイルを添付してください'
    else
      Record.import(params[:file], list, card_id)
      if Record.create(list)
        redirect_to action: "index"
      else
        render :index
      end
    end
  end

  def biorhythm
    @record = Record.new()
    @records = Record.order(date: :DESC)
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
