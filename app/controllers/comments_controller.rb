class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_article, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
    redirect_to user_path(@article.user_id)
      end
  end

  def edit
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

  end

  def update
     if @comment.update_attributes(comment_params)
       redirect_to user_path(@article.user_id)
     else
       render 'edit'
     end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to user_path(@article.user_id)

  end



  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_article
      @article = Article.find(params[:article_id])
  end

  def find_comment
      @comment = @article.comments.find(params[:id])
  end

end
