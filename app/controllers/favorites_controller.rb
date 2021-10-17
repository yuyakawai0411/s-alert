class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @favorite = current_user.favorites.build(card_id: params[:card_id])
    @favorite.save
    redirect_to root_path
  end

  def destroy
    @favorite = Favorite.find_by(card_id: params[:card_id], user_id: current_user.id)
    @favorite.destroy
    if request.referer == ("http://localhost:3000/users/#{current_user.id}")
      redirect_to user_path(current_user.id)
    else
      redirect_to root_path
    end
  end

end
