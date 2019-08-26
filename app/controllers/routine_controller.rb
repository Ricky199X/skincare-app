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
      clean_params = sanitize_data(params)
      if logged_in?
        if clean_params[:name] == "" || clean_params[:description] == ""
          redirect to "/routines/new"
        else
          @routine = current_user.routines.build(name: clean_params[:name], description: clean_params[:description])
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
      clean_params = sanitize_data(params)
      if current_user
         @routine = Routine.find(clean_params[:id])
         erb :'/routines/show'
      else
         redirect to '/login'
      end
   end

   # take user to the edit routine form
   get '/routines/:id/edit' do
      clean_params = sanitize_data(params)
      @routine = Routine.find_by(id: clean_params[:id])
      authenticate_user(@routine)
      if @routine
         erb :'/routines/edit'
      else
         erb :error, layout: false
      end
   end

   patch '/routines/:id' do
      clean_params = sanitize_data(params)
      @routine = Routine.find_by(id: clean_params[:id])
         authenticate_user(@routine)
         @routine.update(name: clean_params[:name], description: clean_params[:description])
      redirect '/routines'
   end

   # delete action
   delete '/routines/:id' do
      authenticate
      clean_params = sanitize_data(params)
      @routine = Routine.find_by(id: clean_params[:id])
      if @routine
         @routine.destroy
         redirect '/routines'
      end
   end

end