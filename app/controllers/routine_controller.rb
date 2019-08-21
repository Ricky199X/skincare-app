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
   # protects from blank values being persisted to database

   post '/routines' do
      if logged_in?
        if params[:name] == "" || params[:description] == ""
          redirect to "/routines/new"
        else
          @routine = current_user.routines.build(name: params[:name], description: params[:description])
          if @routine.save
            redirect to "/routines/#{@routine.id}"
          else
            redirect to "/routines/new"
          end
        end
      else
        redirect to '/login'
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

   # take user to the edit routine form

   get '/routines/:id/edit' do
      @routine = Routine.find_by(id: params[:id])
      authenticate_user(@routine)
      if @routine
         erb :'/routines/edit'
      else
         erb :error, layout: false
      end
   end

   patch '/routines/:id' do
      @routine = Routine.find_by(id: params[:id])
         authenticate_user(@routine)
         @routine.update(name: params[:name], description: params[:description])
      redirect '/routines'
   end

   # delete action
   delete '/routines/:id' do
      authenticate
      @routine = Routine.find_by(id: params[:id])
      if @routine
         @routine.destroy
         redirect '/routines'
      end
   end

end