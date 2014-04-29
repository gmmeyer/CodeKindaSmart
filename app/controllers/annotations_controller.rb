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
    @annotation = Annotation.includes(:document).find(params[:id])
    @document = @annotation.document
  end

  def vote
    @vote = find_or_create_vote
    Annotation.includes(:document).find(params[:id])
    @document = @annotation.document
    if @vote.save
      flash[:notices] = ["Downvoted!"]
      redirect_to annotation_url(@annotation.id)
    else
      flash.now[:errors] = @vote.errors.full_messages
      render :show
    end
  end

  def update
    Annotation.includes(:document).find(params[:id])
    @document = @annotation.document
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

  def vote_params
    params.require(:vote).permit(:user_id, :annotation_id) #also, remember: vote_type and vote exists. Maybe just pass in the vote through the form?
  end

  def find_or_create_vote
    if params[:vote_exists]
      return current_user.votes.new(vote_params)
    else
      vote = current_user.votes.find_by(user_id: params[:user_id])
      vote.vote_type = params[:vote_type]
      return vote
    end
  end
end
