class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:id])
    @comment = @article.comments.create(comment_params)
    @comment.user_id = current_user.id

    if @comment
      flash[:success]="Comment created!"
    else
      flash[:alert]="Oops!"
    end
    redirect_to user_path

  end

  private

  def comment_params
    params.require(:comment).permit(:content)

  end

end
