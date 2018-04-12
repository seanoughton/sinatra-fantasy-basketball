class PlayerController < ApplicationController

	get '/player/new' do
		if logged_in?
			erb :'/players/create_player'
		else
			redirect '/login'
		end
	end



	get '/player/:slug' do
		@player = Player.find_by_slug(params[:slug])
		@user = current_user
		erb :'players/player_show'
	end


	post '/add/playertoteam' do
		binding.pry
		@user = User.find(params[:user][:user_id])
		@player = Player.find(params[:player][:player_id])
		@user.players << @player
	end



	post '/player/new' do
		@player = Player.create(params[:player])
		@player.save
		redirect "/player/#{@player.slug}"
		#"/player/<%=player.slug%>"

	end
end