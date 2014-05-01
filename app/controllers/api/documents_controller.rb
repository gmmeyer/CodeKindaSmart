module Api
	class DocumentsController < ApiController

  def segments
	  @document = Document.includes(:author).includes(:user).includes(annotation: :user).find(params[:id])
	  @document = @document.builder
	  render @document
  end

  def show
  	@document = Document.includes(annotation: :user).find(params[:id])
  	@segments = @document.segments_builder
  	render :segments_builder
  end

	end
end