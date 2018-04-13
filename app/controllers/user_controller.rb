class UserController < ApplicationController

	get '/login' do
		erb :'users/login'
	end

	get '/signup' do
		erb :'users/create_user'
	end

	get '/logout' do
		if logged_in?
      		session.clear
      		redirect '/'
    	else
      		redirect '/'
    	end
	end

	post '/signup' do
		address = ValidEmail2::Address.new(params[:user][:email])
		#test to make sure that the email is in the proper format
		if params[:user][:username].empty? || params[:user][:email].empty? || params[:user][:password].empty? || !address.valid?
			#tell the user someway that they need to enter in a password
      		redirect to '/signup'
    	else
			@user = User.create(params[:user])
			@user.save
      		session[:user_id] = @user.id
      		redirect to '/teams'
		end
		
	end

	post '/login' do
	  	@user = User.find_by(username: params[:username])
	    if @user && @user.authenticate(params[:password])
	      session[:user_id] = @user.id
	      redirect to '/teams'
	    else
	      redirect to '/signup'
	    end
	end


end
