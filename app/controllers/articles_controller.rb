class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end


  def create
    @article = Article.create(article_params)
    if @article.save
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find_by_slug(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article)
    end
  end

  def delete
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:body, :title, :slug, :next_url, :previous_url)
  end
end
