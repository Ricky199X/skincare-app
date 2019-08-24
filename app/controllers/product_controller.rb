class ProductController < ApplicationController

   get '/products' do
      authenticate
      @products = Product.all
      erb :'products/index'
   end

   get '/products' do
      authenticate
      @routine = Routine.find_by(id: params[:id])
      redirect to '/routines/:id/products'
   end
   
   get '/routines/:id/products/new' do
      authenticate
      @routine = Routine.find_by(id: params[:id])
      erb :'products/new'
   end


   # post '/routines/:id/products' do
   #    authenticate
   #    if current_user
   #       @product = Product.create(name: params[:name], category: params[:category])
   #       current_routine.products << @product 
   #       redirect "/routines/#{current_routine.id}"
   #    end
   # end
   

   post '/routines/:id/products' do
      authenticate
      if logged_in?
        if params[:name] == "" || params[:category] == ""
          redirect to "/routines/#{current_routine.id}"
        else
         @product = Product.create(name: params[:name], category: params[:category])
            current_routine.products << @product 
          if @routine
            redirect "/routines/#{current_routine.id}"
          else
            redirect to "/routines/new"
          end
        end
      else
        redirect to '/login'
      end
    end

      get '/products/:id' do
         authenticate
         if current_user
            @product = Product.find(params[:id])
            erb :'/products/show'
         else
            redirect to '/login'
         end
      end

   # # product edit action

   get '/products/:id/edit' do
      @product = Product.find_by(id: params[:id])
      if @product
         erb :'/products/edit'
      else
         redirect to 'products'
      end
   end

   patch '/products/:id' do
      @product = Product.find_by(id: params[:id])
         # authenticate_user(@product)
         @product.update(name: params[:name], category: params[:category])
      redirect '/products'
   end

      # delete product action
      delete '/products/:id' do
         authenticate
         @product = Product.find_by(id: params[:id])
         if @product
            @product.destroy
            redirect '/products'
         end
      end
   

end