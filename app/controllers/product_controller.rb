class ProductController < ApplicationController

   get '/products' do
      authenticate
      @products = Product.all
      erb :'products/index'
   end

   get 'products/new' do
      authenticate
      erb :'products/new'
   end

   #allows user to add a new product
   post '/products' do 
      if Product.find_by(name: params[:name])
         @message = "This product already exists. Please add a new product or choose from the products below."
         redirect to '/products/new'
      else
      @product = Product.create(name: params[:name], category: params[:category])
      # binding.pry
      redirect to "/products/#{@product.id}"
      end
   end

   



end