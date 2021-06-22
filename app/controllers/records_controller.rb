class RecordsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def index
    @card = Card.find(params[:card_id])
    @record = Record.new()
    @records = Record.order(date: :DESC)
  end

  def create
    @card = Card.find(params[:card_id])
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
    params.require(:record).permit(:date, :time_id, :expression_id, :call_id).merge(card_id: params[:card_id])
  end
end
