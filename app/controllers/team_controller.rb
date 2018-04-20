class TeamController < ApplicationController

	get '/teams' do #Read all the teams
		if logged_in?
			@teams = Team.all
			@user = current_user
			erb :'/teams/teams'
		else
			redirect '/login'
		end	
	end

	get '/teams/:slug' do #Read an individual Team
		if logged_in? #USER VALIDATION
			@user = current_user
			if params[:slug] == @user.username
				redirect "/team/#{@user.id}/edit"
			else
				redirect "/teams"
			end
		end	
	end

	get '/team/new' do
		if logged_in? #USER VALIDATION
      		@user = current_user
      		@players = available_players
      		erb :'/teams/create_team'
    	else
      		redirect '/login'
    	end	
	end

	get '/team/new/error' do
		if logged_in? #USER VALIDATION
      		@user = current_user
      		@players = available_players
      		flash[:message] = "Please enter a Team Name and choose at least one player."
      		erb :'/teams/create_team'
    	else
      		redirect '/login'
    	end	
	end

	get '/userteams' do
		if logged_in? #USER VALIDATION
      		@user = current_user
      		erb :'/teams/user_teams'
      	else
      		redirect '/login'
      	end

	end

	get "/team/:id/edit" do
		if team_exists? 
			if logged_in? #USER VALIDATIONS
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
			if logged_in? #USER VALIDATIONS
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

	post '/team/new' do #Create a Team 
		#USER VALIDATIONS
		if params[:team][:teamname].empty? || !params[:team][:player_ids] || params[:team][:player_ids].include?("")
			redirect 'team/new/error'
		else
			team = Team.create(params[:team])
			team.save
			@user = current_user
			@user.teams << team
			redirect '/teams'
		end
	end

	patch '/team/:id/edit' do #Edit a Team
		@team = Team.find(params[:id])
		@team.teamname = params[:team][:teamname]
		#add players to team
		if params[:add_player]
			players_to_add = params[:add_player][:player_ids]
			players_to_add.each do |player_id|
				if player_id != ""
					@team.players << Player.find(player_id)
				end
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

	delete '/team/:id/delete' do #Delete a Team
		if logged_in? #USER VALIDATION
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

	

	helpers do

		def taken_players #returns an array of players on teams
  			Team.all.collect do |team|
  				team.players
  			end

		end

		def available_players #returns an array of available players
  			Player.all.collect do |player|
  				if !taken_players.flatten.include?(player)
  					player
  				end
  			end.compact

		end

		def collect_existing_teams #returns an array of existing teams
			Team.all.collect do |team|
				if team.id == params[:id].to_i
					team
				end
			end.compact
		end

		#checks to see if a team exists, this is here so that the routes won't crash if a user tries to write something like /teams/1/edit, and there is no team with a team_id of 1
		def team_exists? 
			!collect_existing_teams.empty?
		end
	end


end