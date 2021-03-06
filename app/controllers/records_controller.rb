class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :records_info
  before_action :unauthorized_user

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
    csv_file = Record.import(params[:file], @card.id)
    if Record.create(csv_file)
      redirect_to action: "index"
    else
      redirect_to action: "index", alert: 'csvファイルを添付してください'
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

end
