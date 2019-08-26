class ProductController < ApplicationController

   get '/products' do
      authenticate
      @products = Product.all
      erb :'products/index'
   end

   get '/products' do
      authenticate
      clean_params = sanitize_data(params)
      @routine = Routine.find_by(id: clean_params[:id])
      redirect to '/routines/:id/products'
   end
   
   get '/routines/:id/products/new' do
      authenticate
      clean_params = sanitize_data(params)
      @routine = Routine.find_by(id: clean_params[:id])
      erb :'products/new'
   end   

   post '/routines/:id/products' do
      authenticate
      clean_params = sanitize_data(params)
      if logged_in?
        if clean_params[:name] == "" || clean_params[:category] == ""
          redirect to "/routines/#{current_routine.id}"
        else
         @product = Product.create(name: clean_params[:name], category: clean_params[:category])
            current_routine.products << @product 
          if @routine
            redirect "/routines/#{current_routine.id}"
          else
            redirect to "/products"
          end
        end
      else
        redirect to '/login'
      end
    end

      get '/products/:id' do
         authenticate
         clean_params = sanitize_data(params)
         if current_user
            @product = Product.find(clean_params[:id])
            erb :'/products/show'
         else
            redirect to '/login'
         end
      end

   # # product edit action

   get '/products/:id/edit' do
      clean_params = sanitize_data(params)
      @product = Product.find_by(id: clean_params[:id])
      if @product
         erb :'/products/edit'
      else
         redirect to 'products'
      end
   end

   patch '/products/:id' do
      clean_params = sanitize_data(params)
      if current_routine
      @product = Product.find_by(id: clean_params[:id])
         @product.update(name: clean_params[:name], category: clean_params[:category])
         # needs to redirect back to the current routine
         redirect '/routines/#{current_routine.id}'
      end
   end

      # delete product action
      delete '/products/:id' do
         authenticate
         clean_params = sanitize_data(params)
         @product = Product.find_by(id: clean_params[:id])
         if @product
            @product.destroy
            redirect '/products'
         end
      end
   

end