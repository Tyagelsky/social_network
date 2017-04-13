class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit

  end

  def create
    @article = current_user.articles.create(article_params)
    if @article
      flash[:success]="Article created!"
    else
      @feed_items = []
      flash[:alert]="Oops!"
    end
    redirect_to current_user
  end

  def update
    @article.update_attributes(article_params)
     if @article.errors.empty?
       redirect_to current_user
     else
       render 'edit'
     end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to current_user
  end

  private

  def article_params
    params.require(:article).permit(:body,:label, :user_id)
  end

end
