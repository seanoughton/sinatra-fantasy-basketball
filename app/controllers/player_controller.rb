class PlayerController < ApplicationController

	get '/player/:slug' do
		@player = Player.find_by_slug(params[:slug])
		erb :'players/player_show'
	end
end