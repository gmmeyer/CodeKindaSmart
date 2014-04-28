class AnnotationsController < ApplicationController
  def index
  end

  def show
    @annotations = Annotation.where("id IN #{params[:ids]}")
    @document = Document.includes(:author).find(@annotations.first.document_id)
    @document.annotation_segments = @document.segments
    render :show
  end

  def new
    @annotation = Annotation.new
  end

  def create
    @annotation = current_user.annotations.new(annotation_params)
    if @annotation.save
      flash[:notices] = ["You made an annotation!"]
      redirect_to annotation_url(@annotation.id)
    else
      flash.now[:errors] = @annotation.errors.full_messages
      render :new
    end
  end

  def edit
    @annotation = Annotation.find(params[:id])
    @document = @annotation.document
  end

  def upvote
  end

  def downvote
  end

  def update
    @annotation.find(params[:id])
    if @annotation.update(annotation_params)
      flash[:notices] = ["Your annotation has been updated!"]
      redirect_to annotation_url(@annotation.id)
    else
      flash.now[:errors] = @annotation.errors.full_messages
      render :edit
    end
  end

  def destroy
    @annotation = Annotation.find(params[:id])
    @annotation.destroy
    redirect_to document_url(@annotation.document_id)
  end

  private
  def annotation_params
    params.require(:annotation).permit(:title, :body, :document_id, :start_location, :end_location)
  end
end
