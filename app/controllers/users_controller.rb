class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:test_sign_in]
  before_action :user_info, except: [:test_sign_in]
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

  def set_biorhythm
    @theoretical_biortythm_graph = DrawBiortythmGraph.theoretical_biortythm(@user.birth_day, -15, 0)
    @unstable_day = CalculateMinMax.calculate_min(@theoretical_biortythm_graph)
  end
end
