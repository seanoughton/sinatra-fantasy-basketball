class TeamController < ApplicationController

	get '/teams' do
		@teams = Team.all
		erb :'/teams/teams'
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
		@team = Team.find(params[:id])
		erb :'/teams/edit'
	end

	patch '/team/:id/edit' do
		binding.pry
		@team = Team.find(params[:id])
	end

	post '/team/new' do
		team = Team.create(params[:team])
		team.save
		redirect '/teams'
	end


end