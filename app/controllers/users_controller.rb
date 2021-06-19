class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @cards = @user.cards
    @favorites = @user.fav_cards
  end
  
end
