class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @cards = @user.cards
  end
  
end
