require './config/environment'
class ApplicationController < Sinatra::Base

  	configure do
	    set :public_folder, 'public'
	    set :views, 'app/views'
	    enable :sessions
	    set :session_secret, "password_security"
	    use Rack::Flash
  	end

  	get '/' do
  		erb :index
  	end

  	helpers do #USER VALIDATIONS
	    def logged_in? #returns true if logged in
	      !!session[:user_id]
	    end

	    def current_user #returns the current user
	      if session[:user_id]
	        @current_user = User.find(session[:user_id])
	      end
    	end
	end

end