class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to card_path(comment.card.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, card_id: params[:card_id])
  end

end
