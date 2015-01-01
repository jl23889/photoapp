class SearchController < ApplicationController
	def search
		if !params[:search][:query].blank?
			@search_query = params[:search][:query]
			@photos = Photo.text_search(@search_query)
			@albums = Album.text_search(@search_query)
		end
	end
end
