class NoticesController < ApplicationController
before_action :authenticate_user!, only: [:create, :destroy]
before_action :side_menu, only: [:index]
before_action :past_date, only: [:index]

def index
  @notice = Notice.new()
  @notices = @user.notices.order('notice_date ASC')
end

def create
  @notice = Notice.new(notice_params)
  @notice.save
  redirect_to action: "index"
end

def destroy
  @notice = Notice.find(params[:id])
  @notice.destroy
  redirect_to action: "index"
end

private
def notice_params
  params.require(:notice).permit(:notice_date, :description).merge(user_id: current_user.id)
end

def side_menu
  if user_signed_in?
    @user = User.find(current_user.id)
    @user_cards = @user.cards
  end
end

def past_date
  Notice.where("notice_date < ?" , Date.today).delete_all
end

end
