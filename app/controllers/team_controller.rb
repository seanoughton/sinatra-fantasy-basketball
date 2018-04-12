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
      		erb :'/teams/create_team'
    	else
      		redirect '/login'
    	end	
	end

	get "/team/:id/edit" do
		if logged_in?
			@team = Team.find(params[:id])
			@user = current_user
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
		redirect '/teams'
	end


end