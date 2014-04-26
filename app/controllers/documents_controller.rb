class DocumentsController < ApplicationController

  def show
    @document = Document.find(params[:id])
    render :show
  end

  def index
    @documents = Document.all
  end

  def new
    if current_user
      @document = Document.new
      render :new
    else
      flash[:errors] = ["You have to log in to contribute!"]
      redirect_to new_session_url
    end
  end

  def create
    @document = Document.new(document_params)
    @author = find_or_create_author
    
    if @document.save
      if flash[:notices]
        flash[:notices] << "You've created #{@document.title}!"
      else
        flash[:notices] = ["You've created #{@document.title}!"]
      end
      redirect_to document_url(@document.id)
    else
      flash.now[:errors] = @document.errors.full_messages
      render :new
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
  end

  def edit
    @document = Document.find(params[:id])
  end

  private

  def find_or_create_author
    author = Author.find_by(name: author_params[name])
    unless author
      author = Author.new(author_params)
      if author.save
        flash[:notices] = ["You've created a new author: #{author.name}!"]
      else
        flash.now[:errors] = author.errors.full_messages
        render :new
      end
    end
    return @author
  end

  def document_params
    params.require(:document).permit(:title,:body,:summary,:author_id,:release_date, :user_id)
  end

  def author_params
    params.require(:author).permit(:name)
  end
end