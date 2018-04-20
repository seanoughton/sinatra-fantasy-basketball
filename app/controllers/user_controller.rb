class UserController < ApplicationController


	get '/login' do
		flash[:message] = "Please enter a user name and password or signup."
		erb :'users/login'
	end

	get '/signup' do
		erb :'users/create_user'
	end

	get '/signup/problem' do
		flash[:message] = "Please fill out all of the fields."
		erb :'users/create_user'
	end

	get '/signup/usernameproblem' do
		flash[:message] = "This User Name it already taken. Please choose another User Name."
		erb :'users/create_user'
	end

	get '/signup/emailproblem' do
		flash[:message] = "Please enter a correct email address."
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

	post '/signup' do #Create a User

		#USER VALIDATIONS
		address = ValidEmail2::Address.new(params[:user][:email])
		#test to make sure that the email is in the proper format
		if params[:user][:username].empty? || params[:user][:email].empty? || params[:user][:password].empty? 
			flash[:message] = "Please fill out all of the fields."
      		redirect to '/signup/problem'
      	elsif !address.valid?
      		redirect to '/signup/emailproblem'
      	elsif username_exists?
      		redirect to '/signup/usernameproblem'
    	else
			@user = User.create(params[:user])
			@user.save
      		session[:user_id] = @user.id
      		redirect to '/teams'
		end
		
	end

	post '/login' do #Login Authentication
		#USER VALIDATIONS

	  	@user = User.find_by(username: params[:username])
	    if @user && @user.authenticate(params[:password])
	      session[:user_id] = @user.id
	      redirect to '/teams'
	    else
	      redirect to '/login'
	    end
	end

	helpers do

		def username_exists? #Returns true if username is taken
			!!User.find_by(username: params[:user][:username])
		end
	end


end
