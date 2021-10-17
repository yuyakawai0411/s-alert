class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      ActionCable.server.broadcast 'message_channel', content: @comment ,comment_user: current_user.first_name
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to card_path(params[:card_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, card_id: params[:card_id])
  end
end
