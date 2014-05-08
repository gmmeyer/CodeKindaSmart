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

		def save
		end

		def edit
		end

		def update
		end

	end
end