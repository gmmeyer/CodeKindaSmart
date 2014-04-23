class AnnotationController < ApplicationController

	def index
	end

	def show
		@annotation = Annotation.find(params[:id])
	end

	def new
		@annotation = Annotation.new
	end

	def create
		@annotation = Annotation.new(annotation_params)
		if @annotation.save
			redirect_to annotation_url(params[:id])
		else
			flash[:errors] = @annotation.errors.full_messages
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
		params.require(:annotation).params(:title, :body, :user_id, :document_id, 
			:start_location, :end_location)
	end
end
