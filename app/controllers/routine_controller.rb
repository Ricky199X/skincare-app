class RoutineController < ApplicationController

   get '/routines' do
      authenticate
      @routines = Routine.all
      erb :'routines/index'
   end

   get '/routines/new' do
      authenticate
      erb :'routines/new'
   end

   post '/routines' do
      u = current_user
      u.routines.create(name: params[:name], description: params[:description])
         # binding.pry   
      # if routine is saved properly, go to the user's routines page
      if !!u 
         redirect '/routines' 
      else
         @message = "You made an oops! Add a new routine!"
         erb :'routines/new'
      end
   end

end