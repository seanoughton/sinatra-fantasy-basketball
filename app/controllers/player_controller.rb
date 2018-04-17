class PlayerController < ApplicationController

	get '/player/new' do #Read all players
		if logged_in?#USER VALIDATION
			@user = current_user
			erb :'/players/create_player'
		else
			redirect '/login'
		end
	end

	get '/player/new/error' do #Show error for creating new player
		if logged_in?#USER VALIDATION
			@user = current_user
			flash[:message] = "Please fill out all of the fields."
			erb :'/players/create_player'
		else
			redirect '/login'
		end
	end

	get '/player/:id/edit' do
		if logged_in?#USER VALIDATION
			binding.pry
			@player = Player.find(params[:id])
			@user = current_user
			erb :'players/edit'
		else
			redirect '/login'
		end
		
	end



	get '/player/:slug' do #Read a player
		@player = Player.find_by_slug(params[:slug])
		@user = current_user
		erb :'players/player_show'
	end

	get '/players' do
		if logged_in?#USER VALIDATION
			@players = Player.all
			@user = current_user
			erb :'players/players'
		else
			redirect '/login'
		end
	end

	post '/player/new' do #Create a Player
		#USER VALIDATIONS
		params[:player].each do |attribute|
			if attribute[1].empty?
				redirect '/player/new/error'
			end
		end 
		@player = Player.create(params[:player])
		@player.save
		redirect "/player/#{@player.slug}"
		
	end

	patch '/player/:id/edit' do #Edit a Player
		@player = Player.find(params[:id])
		@player.update(params[:player])
		@player.save
		redirect "/player/#{@player.slug}"
	end

	#I intentionally made it NOT possible to delete a player from the overall roster of players.

end