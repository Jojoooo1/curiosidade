class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def new
    @article = Article.new
    @categories = Category.all
  end

  def create
    @categories = Category.all #if creation fails
    @article = Article.create(article_params)
    if @article.save
      childs = params["childs_number"].to_i
      if childs.present?
        @article.slug << "-1" if @article.slug.last != "1"
        @article.next_url = @article.slug.sub(/.{1}$/,"#{2}")
        # start at 0
        [*1..childs].each do |article|
          child = Article.create(parent_id: @article.id, slug: @article.next_url, previous_url: @article.slug)
          child.categories = @article.categories
          if (article != childs )
            child.next_url = @article.slug.sub(/.{1}$/,"#{article + 2}")
          end
          child.save
        end
        @article.save if @article.changed?
        redirect_to view_all_related_article_path(@article), notice: "Article created with success"
      end
      redirect_to article_path(@article), notice: "Article created with success" unless childs.present?
    else
      render :new
    end
  end

  def index
    @articles = Article.where(parent_id: nil).order(:id)
  end

  def view_all_related_article
    @article = Article.find_by_slug(params[:id])
    @childs = @article.childs
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
      childs = params["childs_number"]
      if childs.present?
        @article.slug << "-1" if @article.slug.last != "1"
        @article.next_url = @article.slug.sub!(/.{1}$/,"#{2}")
        childs.to_i.times do |article|
          child = Article.create(parent_id: @article.id, slug: @article.next_url, previous_url: @article.slug)
          child.categories = @article.categories
          if (article != childs)
            child.next_url = @article.slug.sub!(/.{1}$/,"#{article + 2}")
          end
          child.save
        end
        @article.save if @article.changed?
        redirect_to view_all_related_article_path(@article), notice: "Article created with success"
      end
      redirect_to article_path(@article), notice: "Article updated with success" unless childs.present?
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
    params.require(:article).permit({category_ids: []}, :body, :title, :slug, :next_url, :previous_url, :image)
  end
end
