class ProductController < ApplicationController

   get '/products' do
      authenticate
      @products = Product.all
      erb :'products/index'
   end

   get '/products/new' do
      authenticate
      erb :'products/new'
   end

      post '/products' do
         u = current_user
         @product = Product.create(name: params[:name], category: params[:category])
            binding.pry   
         # if routine is saved properly, go to the user's routines page
         if !!u 
            redirect '/products' 
         else
            @message = "You made an oops! Add a new product!"
            erb :'products/new'
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

   



end