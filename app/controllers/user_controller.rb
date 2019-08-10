class UserController < ApplicationController
   # Controls the sessions

   get '/login' do
      redirect '/home' if logged_in?
      @failed = false
      erb :'users/login' 
   end

   # if i don't sign in right, I'll just be rendering my erb again 
   post '/login' do
      user = User.find_by(username: params[:username])
      # wanna set session id
      if !!user && user.authenticate(params[:password])
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
      @user = User.create(username: params[:username], email_address: params[:email_address], password: params[:password])
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
      redirect '/login'
   end
   
end