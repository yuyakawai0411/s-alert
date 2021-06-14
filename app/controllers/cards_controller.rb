class CardsController < ApplicationController
  

  def index
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to root_path
    else
      render :new
    end
  end


  private
  
  def card_params
    params.require(:card).permit(:s_last_name, :s_first_name, :s_last_name_kana, :s_first_name_kana, 
      :s_company, :s_company_form_id, :s_department, :s_phone_number, :s_birth_day).merge(user_id: current_user.id)
  end

end
