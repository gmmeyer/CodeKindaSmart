class DocumentsController < ApplicationController

  def show
    if request.xhr
      @document = Document.includes(:author).includes(:user).includes(:annotations).find(params[:id])
      @document = @document.builder
      render json: @document
    else
      @document = Document.includes(:author).includes(:user).includes(:annotations).find(params[:id])
      @document.annotation_segments = @document.segments
      render :show
    end
  end

  def index
    @documents = Document.includes(:author).all
    @documents.map do |document|
      document.annotation_segments = document.segments
    end
  end

  def new
    if current_user
      @document = Document.new
      @author = Author.new
      render :new
    else
      flash[:errors] = ["You have to log in to contribute!"]
      redirect_to new_session_url
    end
  end

  def create
    @document = Document.new(document_params)
    @author = find_or_create_author
    @document.author_id = @author.id if @author

    if @document.save
      if flash[:notices]
        flash[:notices] << "You've created a new document: #{@document.title}!"
      else
        flash[:notices] = ["You've created #{@document.title}!"]
      end
      redirect_to document_url(@document.id)
    else
      flash.now[:errors] = @document.errors.full_messages
      render :new
    end
  end

  def edit
    @document = Document.find(params[:id])
    @author = @document.author
  end

  def update
    @document = Document.find(params[:id])
    if @document.update(document_params)
      flash[:notices] = ["Your edits on #{@document.title} have been saved!"]
      redirect_to document_url(@document.id)
    else
      flash.now[:errors] = @document.errors.full_messages
      render :edit
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_url
  end

  private
  def find_or_create_author
    author = Author.find_by(name: author_params[:name])
    unless author
      author = Author.new(author_params)
      if author.save
        flash[:notices] = ["You've created a new author: <a href='#{author_url(author.id)}'> #{author.name}!</a>".html_safe]
      end
    end
    return author
  end

  def document_params
    params.require(:document).permit(:title,:body,:summary,:author_id,:release_date, :user_id)
  end

  def author_params
    params.require(:author).permit(:name)
  end
end
