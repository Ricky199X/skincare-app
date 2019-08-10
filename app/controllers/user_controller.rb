class UserController < ApplicationController
   # Controls the sessions

   get '/login' do
      erb :'users/login' 
   end

   # if i don't sign in right, I'll just be rendering my erb again 
   post '/login' do
      user = User.find_by(username: params[:username])
      # wanna set session id
      if !!user && user.authenticate(params[:password])
         session[:user_id] = user.id
         erb :'routines/index'
      else
         erb :'users/login'
      end

   end

   get '/signup' do
      erb :'users/signup'
   end
   
end