class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    @user = User.find(current_user.id)
    if @comment.save
      ActionCable.server.broadcast 'message_channel', content: @comment ,comment_user: @user.first_name
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
