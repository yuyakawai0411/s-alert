class NoticesController < ApplicationController
before_action :authenticate_user!
before_action :notices_info
before_action :remove_past_date_notice, only: [:index]

def index
  @notice = Notice.new()
end

def create
  @notice = Notice.new(notice_params)
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

def notices_info
  @user = current_user
  @notices = @user.notices.order('notice_date ASC')
end

def remove_past_date_notice
  Notice.where("notice_date < ?" , Date.today).delete_all
end

end
