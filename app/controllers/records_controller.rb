class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :records_info
  before_action :unauthorized_user
  before_action :side_menu, only: [:index, :create, :import]

  def index
    @record = Record.new()
  end

  def create
    @record = Record.new(record_params)
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
    if params[:file].blank? || (File.extname(params[:file].original_filename) != ".csv")
      redirect_to action: "index", alert: 'csvファイルを添付してください'
    else
      list = []
      Record.import(params[:file], list, @card.id)
      if Record.create(list)
        redirect_to action: "index"
      else
        render :index
      end
    end
  end

  private

  def record_params
    params.require(:record).permit(:date, :phone_time_id, :expression_id, :phone_call_id).merge(card_id: params[:card_id])
  end

  def records_info
    @card = Card.find(params[:card_id])
    @records = @card.records.order(date: :DESC)
  end

  def unauthorized_user
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
