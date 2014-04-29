class PagesController < ApplicationController

  def homepage
  end

  def search
    # fail
    if params[:query]
      @results = PgSearch.multisearch(params[:query])
    else
      @results = PgSearch::Document
    end
    @results = @results.includes(:searchable).page(params[:page])
  end
end
