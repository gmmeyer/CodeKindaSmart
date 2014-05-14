class AnnotationsController < ApplicationController

  def index
  end

  def show
    if params[:ids]
      @annotations = Annotation.includes(document: [:user, :author]).where("id IN (?)", params[:ids])
    else
      @annotations = [Annotation.find(params[:id])]
    end
    @annotations.map do |annotation|
      annotation.load_user_vote(current_user)
    end
    @document = @annotations.first.document
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
    if !current_user
      flash[:errors] = ["You must be logged in to vote!"]
    else
      @annotation = Annotation.find(params[:vote][:annotation_id])
      @annotation.load_user_vote(current_user)
      if @annotation.my_vote.class == DownVote
        @annotation.my_vote.destroy
        flash[:notices] = ["Your vote has been deleted"]
      elsif @annotation.my_vote.class == UpVote
        @annotation.my_vote.destroy
        @downvote = current_user.downvotes.new(vote_params)
      else
        @downvote = current_user.downvotes.new(vote_params)
      end

      if @downvote && @downvote.save
        flash[:notices] = ["Your vote has been recorded."]
      elsif @downvote
        flash[:errors] = @downvote.errors.full_messages
      end
    end
    
    redirect_to annotation_url(params[:vote][:annotation_id])
  end

  def upvote
    if !current_user
      flash[:errors] = ["You must be logged in to vote!"]
    else
      @annotation = Annotation.find(params[:vote][:annotation_id])
      @annotation.load_user_vote(current_user)
      if @annotation.my_vote.class == UpVote
        @annotation.my_vote.destroy
        flash[:notices] = ["Your vote has been deleted"]
      elsif @annotation.my_vote.class == DownVote
        @annotation.my_vote.destroy
        @upvote = current_user.upvotes.new(vote_params)
      else
        @upvote = current_user.upvotes.new(vote_params)
      end

      if @upvote && @upvote.save
        flash[:notices] = ["Your vote has been recorded."]
      elsif @upvote
        flash[:errors] = @upvote.errors.full_messages
      end
    end

    redirect_to annotation_url(params[:vote][:annotation_id])
  end

  private
  def annotation_params
    params.require(:annotation).permit(:title, :body, :document_id, :start_location, :end_location)
  end

  def vote_params
    params.require(:vote).permit(:user_id, :annotation_id)
  end
end
