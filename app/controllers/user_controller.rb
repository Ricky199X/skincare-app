class UserController < ApplicationController
   # Controls the sessions

   get '/login' do
      erb :'users/login' 
   end

   post '/login' do
      user = User.find_by
   end

   get '/signup' do
      erb :'users/signup'
   end
   
end