class PagesController < ApplicationController
  def home
    @latest_articles = Article.last(10)
  end

  def home_by_category
    @category = params[:category]
    @articles = Article.joins(:categories).where(:categories => {:label => @category})
  end


end
