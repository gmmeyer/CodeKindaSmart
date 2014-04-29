class PagesController < ApplicationController

  def homepage

  end

  def search
    # fail
    if params[:query]
      @results = PgSearch.multisearch(params[:query])
      # @results = PgSearch.search_documents(params[:query])
    else
      @results = PgSearch::Document
    end
    @results = @results.includes(:searchable).page(params[:page])
  end


end