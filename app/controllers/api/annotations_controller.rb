module Api
	class AnnotationsController < ApiController

		def index
			@document = Document.includes(annotations: [:user]).find(params[:document_id])
			@annotations = @document.annotations.includes(:user)
			render :index
		end

		def show
			@annotation = Annotation.includes(:user).includes(document: [:user, :author]).find(params[:id])
		end

	  def create
	  	if params[:id]
		  	@annotation = Annotation.find(params[:id])
	  		if @annotation.update(annotation_params)
	  			render "annotations/show"
	  		else
	  			render @annotation.errors.full_messages
	  		end
	  	else
		    @annotation = current_user.annotations.new(annotation_params)
		    if @annotation.save
		      # flash[:notices] = ["You made an annotation!"]
		      render json: @annotation
		    else
		      render json: @annotation.errors.full_messages
		    end
		  end
	  end

		def save

		end

		def edit
		end

		def update
			Annotation.find(params[:id])
			if @annotation.update(annotation_params)
				render "annotations/show"
			else
				render @annotation.errors.full_messages
			end
		end

		def downvote
    if !current_user
      flash[:errors] = ["You must be logged in to vote!"]
    else
      @annotation = Annotation.find(params[:id])
      @annotation.load_user_vote(current_user)
      if @annotation.my_vote.class == DownVote
        @annotation.my_vote.destroy
        # flash[:notices] = ["Your vote has been deleted"]
      elsif @annotation.my_vote.class == UpVote
        @annotation.my_vote.destroy
        @downvote = current_user.downvotes.new(annotation_id: params[:id])
      else
        @downvote = current_user.downvotes.new(annotation_id: params[:id])
      end

      if @downvote && @downvote.save
        # flash[:notices] = ["Your vote has been recorded."]
      elsif @downvote
        # flash[:errors] = @downvote.errors.full_messages
      end
    end
    
    render json: @annotation
  end

  def upvote
    if !current_user
      flash[:errors] = ["You must be logged in to vote!"]
    else
      @annotation = Annotation.find(params[:id])
      @annotation.load_user_vote(current_user)
      if @annotation.my_vote.class == UpVote
        @annotation.my_vote.destroy
        # flash[:notices] = ["Your vote has been deleted"]
      elsif @annotation.my_vote.class == DownVote
        @annotation.my_vote.destroy
        @upvote = current_user.upvotes.new(annotation_id: params[:id])
      else
        @upvote = current_user.upvotes.new(annotation_id: params[:id])
      end

      if @upvote && @upvote.save
        # flash.now[:notices] = ["Your vote has been recorded."]
      elsif @upvote
        # flash.now[:errors] = @upvote.errors.full_messages
      end
    end

    render json: @annotation
  end

		def destroy
			annotation = Annotation.find(params[:id])
			annotation.destroy
			render json: annotation
		end

		private
	  def annotation_params
	    params.require(:annotation).permit(:title, :body, :document_id, :start_location, :end_location)
	  end

	  # def vote_params
	  # 	params.require(:vote).permit(:user_id, :annotation_id)
	  # end

	end
end