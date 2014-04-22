class DocumentsController < ApplicationController

  def show
    @document = Document.find(:id)
    render :show
  end

  def index
  end

  def new
  end

  def create
  end

  def destroy
  end

  def edit
  end

end