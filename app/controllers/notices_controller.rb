class NoticesController < ApplicationController
before_action :authenticate_user!, only: [:index, :create, :destroy]
before_action :side_menu, only: [:index, :create]

def index
  past_date_delete
  @notice = Notice.new()
  @notices = @user.notices.order('notice_date ASC')
end

def create
  @notice = Notice.new(notice_params)
  @notices = @user.notices.order('notice_date ASC')
  if @notice.save
    redirect_to action: "index"
  else
    render :index
  end
end

def destroy
  @notice = Notice.find(params[:id])
  @notice.destroy
  redirect_to action: "index"
end

private
def notice_params
  params.require(:notice).permit(:notice_date, :description, :topic).merge(user_id: current_user.id)
end

def side_menu
  if user_signed_in?
    @user = User.find(current_user.id)
    @user_cards = @user.cards
  end
end

def past_date_delete
  Notice.where("notice_date < ?" , Date.today).delete_all
end

end
