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
	    @annotation = current_user.annotations.new(annotation_params)
	    if @annotation.save
	      flash[:notices] = ["You made an annotation!"]
	      render json: @annotation
	    else
	      render json: @annotation.errors.full_messages
	    end
	  end

		def save

		end

		def edit
		end

		def update
		end

		private
	  def annotation_params
	    params.require(:annotation).permit(:title, :body, :document_id, :start_location, :end_location)
	  end

	end
end