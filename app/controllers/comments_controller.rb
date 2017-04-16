class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:id])
    @comment = @article.comments.create(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to current_user
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:content)

  end

end
