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
		if team_exists?
			if logged_in?
			@team = Team.find(params[:id])
			@user = current_user
			@players = available_players
			erb :'/teams/edit'
			else
				redirect '/login'
			end
		else
			redirect '/teams'
		end
	end

	get "/team/:id/delete" do
		if team_exists?	
			if logged_in?
				@team = Team.find(params[:id])
				@user = current_user
				erb :'/teams/delete'
			else
				redirect '/login'
			end
		else
			redirect '/teams'
		end
	end

	patch '/team/:id/edit' do
		@team = Team.find(params[:id])
		@team.teamname = params[:team][:teamname]
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

	delete '/team/:id/delete' do
		if logged_in?
			if params[:id]
				@team = Team.find(params[:id])
				@team.delete
				redirect '/teams'
			else
				redirect '/teams'
			end
		else
			redirect '/login'
		end
		
	end

	post '/team/new' do
		if !params[:team][:teamname] || !params[:team][:player_ids]
			redirect 'team/new'
		else
			team = Team.create(params[:team])
			team.save
			@user = current_user
			@user.teams << team
			redirect '/teams'
		end
	end

	helpers do

		def taken_players
			#@taken_players = []
      		#Team.all.each do |team|
  				#@taken_players << team.players
  			#end
  			#@taken_players

  			Team.all.collect do |team|
  				team.players
  			end

		end

		def available_players
=begin
			@available_players = []
  			Player.all.each do |player|
  				if !taken_players.flatten.include?(player)
  					@available_players << player
  				end
  			end
  			@available_players
=end
			
  			Player.all.collect do |player|
  				if !taken_players.flatten.include?(player)
  					player
  				end
  			end.compact

		end

		def collect_existing_teams
			Team.all.collect do |team|
				if team.id == params[:id]
					team
				end
			end.compact
		end

		def team_exists?
			!collect_existing_teams.empty?
		end
	end


end