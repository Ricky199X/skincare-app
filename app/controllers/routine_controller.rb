class RoutineController < ApplicationController

   get '/routines' do
      authenticate
      @routines = Routine.all
      erb :'routines/index'
   end

   get '/routines/new' do
      if logged_in?
         erb :'routines/new'
      else
         redirect to '/login'
      end
   end

   post '/routines/search' do
      @user = current_user
      @user_routines = Routine.all.select {|routine| routine.products.any? {|product| product.name == ""}}
      # @routines = Routine.find_by(params[:name])
      erb :'routines/index'
   end

   # allows user to create a new routine via the UI, persists it to the database + adds to the user's routine index
   # protects from blank values being persisted to database
   post '/routines' do
      authenticate
      if logged_in?
        clean_params = sanitize_data(params)
         if clean_params[:name] == "" || clean_params[:description] == ""
            redirect to "/routines/new"
         else
            @routine = current_user.routines.create(name: clean_params[:name], description: clean_params[:description])
            authenticate_user(@routine)
            if @routine
               redirect to "/routines"
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
      if logged_in?
         clean_params = sanitize_data(params)
         @routine = Routine.find(clean_params[:id])
         authenticate_user(@routine)
         erb :'/routines/show'
      else
         redirect to '/login'
      end
   end

   # take user to the edit routine form -> edits only routine and description
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

   # add a product to current routine you're looking at 
   get '/routines/:id/products/new' do
      authenticate
         clean_params = sanitize_data(params)
         @routine = Routine.find_by(id: clean_params[:id])
      erb :'products/new'
   end   
   
   # post a new product to the current routine & protects against blank values
   post '/routines/:id/products' do
      authenticate
      clean_params = sanitize_data(params)
      if logged_in?
         if clean_params[:name] == "" || clean_params[:category] == ""
            redirect to "/routines/#{current_routine.id}"
         else
            @product = Product.create(name: clean_params[:name], category: clean_params[:category])
            current_routine.products << @product 
            redirect "/routines/#{current_routine.id}"
         end
      end
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