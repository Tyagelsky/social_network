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
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success]="Article created!"
      redirect_to root_path
    else
      flash[:alert]="Oops!"
      render :new
    end
  end

  def update
    @article.update_attributes(article_params)
     if @article.errors.empty?
       redirect_to root_path
     else
       render 'edit'
     end
  end

  def destroy
    @article.destroy
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:body, :user_id)
  end

end
