require 'open-uri'

class Movie < ActiveRecord::Base
	belongs_to :user
	has_many :reviews

	has_attached_file :image , styles: {medium: "400x600>" , small: "300x300>" , thumb: "150x150>"}
	has_attached_file :remote_image , styles: {medium: "400x600>" , small: "300x300>" , thumb: "150x150>"}


	validates_attachment_content_type :image , content_type: /\Aimage\/.*\Z/
	validates_attachment_content_type :remote_image , content_type: /\Aimage\/.*\Z/

	def upload_from_url(url)
		self.image = open(url)
	end


end
