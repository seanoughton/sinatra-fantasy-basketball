class Player < ActiveRecord::Base

	belongs_to :team

	def slug
   		playername.downcase.gsub(" ","-")
  	end

   	def self.find_by_slug(slug)
     	Player.all.find{|player| player.slug == slug}
   	end

end