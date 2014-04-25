class AnnotationsController < ApplicationController
	def index
	end

	def show
		@annotations = Annotation.where("id IN #{params[:ids]}")
		@document = Document.find(@annotations.first.document_id)
		render :show
	end

	def new
		@annotation = Annotation.new
	end

	def create
		@annotation = Annotation.new(annotation_params)
		if @annotation.save
			flash[:notices] = ["You made an annotation!"]
			redirect_to document_url(@annotation.document_id)
		else
			flash.now[:errors] = @annotation.errors.full_messages
			render :new
		end
	end

	def edit
	end

	def destroy
		@annotation.find(params[:id])
		@annotation.destroy
	end

	private
	def annotation_params
		params.require(:annotation).permit(:title, :body, :user_id, :document_id, :start_location, :end_location)
	end
end
