class TeamController < ApplicationController

	get '/teams' do
		if logged_in?
			@teams = Team.all
			@user = current_user
			erb :'/teams/teams'
		else
			redirect '/login'
		end	
	end

	get '/teams/:slug' do
		if logged_in?
			@user = current_user
			if params[:slug] == @user.username
				redirect "/team/#{@user.id}/edit"
			else
				redirect "/teams"
			end
		end	
	end

	get '/team/new' do
		if logged_in?
      		@user = current_user
      		@players = available_players
      		erb :'/teams/create_team'
    	else
      		redirect '/login'
    	end	
	end

	get "/team/:id/edit" do
		if logged_in?
			@team = Team.find(params[:id])
			@user = current_user
			@players = available_players
			erb :'/teams/edit'
		else
			redirect '/login'
		end
	end

	patch '/team/:id/edit' do
		@team = Team.find(params[:id])

		#add players to team
		if params[:add_player]
			players_to_add = params[:add_player][:player_ids]
			players_to_add.each do |player_id|
			@team.players << Player.find(player_id)
			end
		end
		
		#remove players from team
		if params[:remove_player]
			players_to_remove = params[:remove_player][:player_ids]
			players_to_remove.each do |player_id|
				@team.players.delete(player_id)
			end
		end

		@team.save
		redirect '/teams'
	end

	post '/team/new' do
		team = Team.create(params[:team])
		team.save
		@user = current_user
		@user.teams << team
		redirect '/teams'
	end

	helpers do
		#rewrite these with collect or map or tap or something
		def taken_players
			@taken_players = []
      		Team.all.each do |team|
  				@taken_players << team.players
  			end
  			@taken_players
		end

		def available_players
			@available_players = []
  			Player.all.each do |player|
  				if !taken_players.flatten.include?(player)
  					@available_players << player
  				end
  			end
  			@available_players
		end
	end


end