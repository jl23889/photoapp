class CommentsController < ApplicationController
	def create
	  @photo = Photo.find(params[:photo_id])
	  @comment = @photo.comments.create!(params[:comment].permit!)
	  redirect_to @photo, notice: "Comment created!"
	end
end
