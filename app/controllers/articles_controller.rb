class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_article, only: [ :edit, :update, :destroy]


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
      if @article.update_attributes(article_params)
       redirect_to current_user
     else
       render 'edit'
     end
  end

  def destroy
    @article.destroy
    redirect_to current_user
  end

  private
  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:body,:label, :user_id, :file)
  end

end
