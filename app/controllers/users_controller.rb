class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :side_menu, only: [:show]
  before_action :set_biorhythm, only: [:show]

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

  def set_biorhythm
    # 登録された誕生日を元に、現在から前後2週間のバイオリズムグラフを作成
    pi = Math::PI
    birth_day = @user.birth_day
    today = Date.today  
    delta = today - birth_day
    @biorhythm_graph= {}
    i = -15

    30.times do 
      key = today.next_day(i)
      value = Math.sin(2 * pi * (delta + i) / 28)
      @biorhythm_graph.store( "#{key}", value )
      i = i + 1
    end
    # バイオリズムグラフの中から不安定日(0に近い値)を2つ算出
    @unstable = @biorhythm_graph.min_by(2){|x,v| (v - 0).abs}
  end

end
