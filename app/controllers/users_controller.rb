class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :side_menu, only: [:show]
  before_action :bio_risum_data, only: [:show]

  def show
    @user = User.find(params[:id])
    @cards = @user.cards
    @favorites = @user.fav_cards
  end

  private
  def side_menu
    if user_signed_in?
      @user = User.find(current_user.id)
      @user_cards = @user.cards
    end
  end

  def bio_risum_data
    pi = Math::PI
    birth_day = @user.birth_day
    today = Date.today  
    delta = today - birth_day
    bio_reism = {}
    i = -15

    30.times do 
      key = today.next_day(i)
      value = Math.sin(2 * pi * (delta + i) / 28)
      bio_reism.store( "#{key}", value )
      i = i + 1
    end
    @bio_reism = bio_reism
    @bad_date = @bio_reism.min_by(2){|x,v| (v - 0).abs}
  end

end
