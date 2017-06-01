class PagesController < ApplicationController
  def home
    # To redo
    @main_articles = Article.last(3)
    @main_small_articles = Article.first(3)
    @latest_articles = Article.last(10)
  end

  def home_by_category
    @category = params[:category]
    @articles = Article.joins(:categories).where(:categories => {:label => @category})
  end


end
