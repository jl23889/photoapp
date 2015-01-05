class Photo
	include Mongoid::Document
	include Mongoid::Paperclip
	field :name
	field :category
	validates_presence_of :name
	validates_presence_of :category	

	belongs_to :user
	embeds_many :comments
	has_and_belongs_to_many :albums

	index({ name: 1 }, { unique: true })

	#for photo uploads
	has_mongoid_attached_file :image,
		styles: { thumb: "180x180>" }
	validates_attachment :image, 
		presence: true,
		content_type: { content_type: "image/jpeg" }
end
