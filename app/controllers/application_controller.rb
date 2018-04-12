require './config/environment'
require 'csv'
class ApplicationController < Sinatra::Base

  	configure do
	    set :public_folder, 'public'
	    set :views, 'app/views'
	    enable :sessions
	    set :session_secret, "password_security"
  	end

  	get '/' do
  		erb :index
  	end

  	helpers do
	    def logged_in? #returns true if logged in
	      !!session[:user_id]
	    end

	    def current_user
	      if session[:user_id]
	        @current_user = User.find(session[:user_id])
	      end
    	end
	end

end