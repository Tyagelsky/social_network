class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success]="Comment created!"
    else
      flash[:alert]="Oops!"
    end
    redirect_to current_user

  end

  private

  def comment_params
    params.require(:comment).permit(:content)

  end

end
