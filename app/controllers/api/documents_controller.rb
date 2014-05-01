module Api
	class DocumentsController < ApiController

  def segments
	  @document = Document.includes(:author).includes(:user).includes(annotation: :user).find(params[:id])
	  @document = @document.segments_builder
	  render @document
  end

  def show
  	@document = Document.includes(annotation: :user).find(params[:id])
  	@segments = @document.builder
  	render :segments_builder
  end

	end
end