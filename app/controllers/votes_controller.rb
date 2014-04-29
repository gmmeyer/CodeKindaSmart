class VotesController < ApplicationController
  def downvote
    if params[:voted]
      @downvote = current_user.downvotes.new(vote_params)
    else
      @downvote = current_user.downvotes.find_by(annotaiton_id: params[:annotation_id])
      @downvote.type = params[:type]
    end
  end

  def upvote
    if params[:voted]
      @upvote = current_user.downvotes.new(vote_params)
    else
      @upvote = current_user.downvotes.find_by(annotaiton_id: params[:annotation_id])
      @upvote.type = params[:type]
    end
  end

  def remove_vote
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

  private
  def vote_params
    params.require(:vote).permit(:user_id, :annotation_id) #also, remember: vote_type and vote exists. Maybe just pass in the vote through the form?
  end

  def find_or_create_vote #this is ripe for metaprogramming
    if params[:vote_exists]
      return current_user.votes.new(vote_params)
    else
      vote = current_user.votes.find_by(user_id: params[:user_id])
      vote.vote_type = params[:vote_type]
      return vote
    end
  end
end
