class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def new
    @article = Article.new
    @categories = Category.all
  end


  def create
    @article = Article.create(article_params)
    if @article.save
      redirect_to article_path(@article), notice: "Article created with success"
    else
      render :new
    end
  end

  def index
    @articles = Article.all.order(:id)
  end

  def show
    @article = Article.find_by_slug(params[:id])
    # get related article based on first category
    @related_articles = Article.joins(:categories).where(:categories => {:label => @article.categories.first.label})
    @viral_articles = Article.joins(:categories).where(:categories => {:label => 'viral'})
  end

  def edit
    @article = Article.find_by_slug(params[:id])
    @categories = Category.all
  end

  def update
    @article = Article.find_by_slug(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: "Article updated with success"
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find_by_slug(params[:id])
    @article.destroy
    redirect_to articles_path, notice: "Article removed with success"
  end

  private

  def article_params
    params.require(:article).permit(:body, :title, :slug, :next_url, :previous_url, :image, :category_ids)
  end
end
