module Api
	class DocumentsController < ApiController

    def show
  	  @document = Document.includes(:author).includes(:user).includes(annotations: :user).find(params[:id])
  	  render :show
    end

    def segments
    	document = Document.includes(annotations: :user).find(params[:id])
    	@sorted_segments = document.sort_segments
    	render :segments
    end

    def destroy 
      document = Document.find(params[:id])
      document.destroy
      render json: document
    end

	end
end