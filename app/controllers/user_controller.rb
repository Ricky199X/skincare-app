class UserController < ApplicationController
   # Controls the sessions

   get '/login' do
      redirect '/home' if logged_in?
      @failed = false
      erb :'users/login' 
   end

   # if i don't sign in right, I'll just be rendering my erb again 
   post '/login' do
      clean_params = sanitize_data(params)
      user = User.find_by(username: clean_params[:username])
      # wanna set session id
      if !!user && user.authenticate(clean_params[:password])
         session[:user_id] = user.id
         redirect '/home'
      else
         @failed = true
         erb :'users/login'
      end

   end

   get '/signup' do
      redirect '/home' if logged_in?
      erb :'users/signup'
   end

   post '/users' do
      clean_params = sanitize_data(params)
      # binding.pry
      @user = User.create(username: clean_params[:username], email_address: clean_params[:email_address], password: clean_params[:password])
      # check if there are any errors
      if @user.errors.any?
         erb :'users/signup'
      else
         # redirect user to user homepage
         session[:user_id] = @user.id 
         redirect '/home'
      end
   end

   delete '/logout' do
      session.clear
      erb :'/index'
   end
   
end