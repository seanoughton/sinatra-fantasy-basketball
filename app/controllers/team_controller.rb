class TeamController < ApplicationController

	get '/teams' do
		@teams = Team.all
		erb :'/teams/teams'
	end

	get '/create/team' do
		if logged_in?
      		@user = current_user
      		erb :'/teams/create_team'
    	else
      		redirect '/login'
    	end	
	end

end