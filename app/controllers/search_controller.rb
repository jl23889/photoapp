class SearchController < ApplicationController
	def search
		if !params[:search][:query].blank?
			@photos = Photo.text_search(params[:search][:query])
			@albums = Album.text_search(params[:search][:query])
		end
	end
end
