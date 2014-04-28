class PagesController < ApplicationController

  def homepage

  end

  def search
    if params[:query]
      @results = Document.search_documents(params[:query])
    else
      @results = PgSearch::Document
    end
    @results = @results.page(params[:page])
  end


end
