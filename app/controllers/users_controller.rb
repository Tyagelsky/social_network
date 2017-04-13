class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
    @article = current_user.articles.build
    @feed_items = current_user.feed
  end
end