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

  def downvote
    if params[:existing_vote].class == DownVote
      params[:existing_vote].destroy
      @downvote = nil
    elsif params[:existing_vote].class == UpVote
      @downvote = current_user.downvotes.new(vote_params)
      params[:existing_vote].destroy
    else
      @downvote = current_user.downvotes.new(vote_params)
    end

    if @downvote.nil? || @downvote.save
      flash[:notices] = ["Your vote has been recorded."]
      redirect_to annotation_url(params[:annotation_id])
    else
      flash.now[:errors] = @downvote.errors
      render :show
    end
  end

  def upvote
    if params[:existing_vote].class == UpVote
      params[:existing_vote].destroy
      @upvote = nil
    elsif params[:existing_vote].class == DownVote
      @upvote = current_user.upvotes.new(vote_params)
      params[:existing_vote].destroy
    else
      @upvote = current_user.upvotes.new(vote_params)
    end

    if @upvote.nil? || @upvote.save
      flash[:notices] = ["Your vote has been recorded."]
      redirect_to annotation_url(params[:annotation_id])
    else
      flash.now[:errors] = @upvote.errors.full_messages
      render :show
    end
  end

  private
  def annotation_params
    params.require(:annotation).permit(:title, :body, :document_id, :start_location, :end_location)
  end
  
  def vote_params
    params.require(:vote).permit(:user_id, :annotation_id) #also, remember: vote_type and vote exists. Maybe just pass in the vote through the form?
    # existing_vote
  end
end
