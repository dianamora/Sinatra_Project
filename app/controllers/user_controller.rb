class UserController < ApplicationController

    get '/users/signup' do
        erb :'users/signup'
    end

    post '/users/signup' do

        if params[:username] == "" && params[:password] == ""
            redirect "/users/signup"
        else
            @user = User.create(
            username: params[:username], 
            password: params[:password]
         )
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
         end
    end

    get '/users/login' do
        #if user is logged in, redirect to their homepage
        #else, show them the login form
        erb :'/users/login'
    end

    post '/users/login' do
        #first we want to find the user if it exists
        #if user exists, then we want to authenticate password
        @user = User.find_by(username: params[:username])

    end

    get '/users/:id' do 
        @user = User.find(params[:id])
         erb :'users/show'
    end

end