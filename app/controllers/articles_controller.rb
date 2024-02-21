class ArticlesController < ApplicationController

  before_action :authenticate_user!

  # before_action :authenticate_user!, except: [:index, :show]
  # before_action :set_article, only: [:show, :edit, :update, :destroy]
  # before_action :authorize_user, only: [:edit, :update, :destroy]


  
  def index
    @articles = Article.all
  end

  def show 
    @article = Article.find(params[:id])
  end

  def new 
    @article = current_user.articles.build
  end

  def create 
    
    @article = current_user.articles.build(article_params)
    if @article.save
      current_user.add_role :author, @article 
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def edit 
    @article = Article.find(params[:id])
  end 

  def update 
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to root_path
    else
      render :edit, status: 422
    end
  end

  def destroy
    @article = Article.find(params[:id])

    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private 

  def article_params
    params.require(:article).permit(:title,:body)
  end

  # def set_article
  #   @article = Article.find(params[:id])
  # end

  # def authorize_user
  #   redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user == @article.user
  # end

end
