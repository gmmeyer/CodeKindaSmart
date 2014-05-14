module Api
	class DocumentsController < ApiController

  def show
	  @document = Document.includes(:author).includes(:user).includes(annotations: :user).find(params[:id])
	  # @document = @document.builder
	  render :show
  end

  def segments
  	document = Document.includes(annotations: :user).find(params[:id])
  	@sorted_segments = document.sort_segments
  	render :segments
  end

	end
end