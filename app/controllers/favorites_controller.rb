class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @favorite = current_user.favorites.build(card_id: params[:card_id])
    @favorite.save
    redirect_to root_path
    
  end

  def destroy
    @favorite = Favorite.find_by(card_id: params[:card_id], user_id: current_user.id)
    @favorite.destroy
    redirect_to root_path
  end

end
