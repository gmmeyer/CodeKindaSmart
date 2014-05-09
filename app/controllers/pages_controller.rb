class PagesController < ApplicationController

  def homepage
    # here's how we need to design the fetch for this:
    # fetch .order('ranking DESC').first(10)


  end

  def search
    if params[:query]
      @results = PgSearch.multisearch(params[:query])
    else
      @results = PgSearch::Document
    end
    @results = @results.includes(:searchable).page(params[:page])
  end
end
