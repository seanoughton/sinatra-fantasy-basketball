class PlayerController < ApplicationController

	get '/player/new' do
		if logged_in?
			@user = current_user
			erb :'/players/create_player'
		else
			redirect '/login'
		end
	end

	get '/player/:id/edit' do
		if logged_in?
			binding.pry
			@player = Player.find(params[:id])
			@user = current_user
			erb :'players/edit'
		else
			redirect '/login'
		end
		
	end



	get '/player/:slug' do
		@player = Player.find_by_slug(params[:slug])
		@user = current_user
		erb :'players/player_show'
	end

	post '/player/new' do
		params[:player].each do |attribute|
			if attribute[1].empty?
				redirect '/player/new'
			end
		end 
		@player = Player.create(params[:player])
		@player.save
		redirect "/player/#{@player.slug}"
		
	end

	patch '/player/:id/edit' do
		@player = Player.find(params[:id])
		@player.update(params[:player])
		@player.save
		redirect "/player/#{@player.slug}"
	end

end