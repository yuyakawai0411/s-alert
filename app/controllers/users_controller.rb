class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:test_sign_in]
  before_action :user_info, except: [:test_sign_in]
  before_action :side_menu, only: [:show, :edit, :destroy, :post_cards, :favorite_cards]
  before_action :set_biorhythm, only: [:show]

  def test_sign_in
    test_user = User.create_test_user
    sign_in test_user
    redirect_to root_path
  end

  def show
    @cards = @user.cards.last(3)
    @favorites = @user.fav_cards.last(3)
  end

  def edit

  end

  def update
    if @user.update(user_params)  
      sign_in(@user, bypass: true)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  def post_cards
    @cards = @user.cards.page(params[:page]).per(9)
  end 
  
  def favorite_cards
    @favorites = @user.fav_cards.page(params[:page]).per(9)
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :company, :company_form_id, :department, :phone_number, :birth_day)
  end
  
  def user_info
    @user = User.includes([cards: {image_attachment: :blob}, fav_cards: {image_attachment: :blob}]).find(params[:id])
  end

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
