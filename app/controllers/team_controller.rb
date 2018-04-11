class TeamController < ApplicationController

	get '/teams' do
		binding.pry
		@teams = Teams.all
		erb :'/teams/teams'
	end

end