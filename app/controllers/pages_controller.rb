class PagesController < ApplicationController
  def home
    if params[:page].nil? || params[:page] == "1"
      @main_articles = Article.last(3)
      @main_small_articles = Article.first(3)
    end
    @latest_articles = Article.order(:created_at).page params[:page]
  end

  def home_by_category
    @category = params[:category]
    @articles = Article.joins(:categories).where(:categories => {:label => @category}).order(:created_at).page params[:page]
  end


end
