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

   # allows user to create a new routine via the UI, persists it to the database + adds to the user's routine index
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

   # show the routine the user clicks on in their index 
   get '/routines/:id' do
      authenticate
      if current_user
         @routine = Routine.find(params[:id])
         erb :'/routines/show'
      else
         redirect to '/login'
      end
   end

end