class DocumentsController < ApplicationController

  def show
    @document = Document.find(params[:id])
    render :show
  end

  def index
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to document_url(@document.id)
    else
      flash[:errors] = @document.errors.full_messages
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

  def document_params
    params.require(:document).permit(:title,:document,:summary,
                                      :title,:author,:release_date)
  end
end