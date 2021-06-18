class RecordsController < ApplicationController
  
  def index
    @card = Card.find(params[:card_id])
    @record = Record.new()
    @records = Record.all
  end

  def create
    @card = Card.find(params[:card_id])
    @record = Record.new(record_params)
    if @record.save
      redirect_to action: "index" #card_record_path(@card)
    else
      render :index
    end
      
    
  end

  def edit
  
  end

  def update 

  end

  def destroy
  
  end

  private

  def record_params
    params.require(:record).permit(:phone_day, :phone_time_id, :expression_id).merge(card_id: params[:card_id])
  end
end
