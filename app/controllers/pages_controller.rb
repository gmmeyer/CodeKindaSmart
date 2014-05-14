class PagesController < ApplicationController

  def homepage
    # here's how we need to design the fetch for this:
    # fetch .order('ranking DESC').first(10)

    @users = User.order('rank DESC').first(10)
    @documents = Document.order('rank DESC').first(10)
    @annotations = Annotation.order('rank DESC').first(10)

    @new_documents = Document.order('created_at DESC').first(5)
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