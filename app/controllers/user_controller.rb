class UserController < ApplicationController
	def home
		@photos = current_user.photos
		@albums = current_user.albums 
	end
end
